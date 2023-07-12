import 'package:collection/collection.dart';
import 'package:library_app/books/borrow.dart';
import 'package:library_app/books/copy.dart';
import 'package:library_app/books/reservation.dart';
import 'package:library_app/mocks.dart';
import 'package:library_app/books/book.dart';
import 'package:library_app/strategies/borrow/borrow_strategy.dart';
import 'package:library_app/users/user.dart';

/// Library System manager following the Command and Singleton patterns.
///
/// This class has some internal fields, namely `users`, `books` and `bookCopies`
/// containing crucial test data. This data could ~(and should)~
/// be instanced on a proper mock structure and only be used during unit testing.
/// With that said, the project specification explicitly suggested to store
/// this date in memory during startup, so that was the chosen approach.
class LibrarySystem {
  /// Creates a [LibrarySystem] singleton.
  LibrarySystem._privateConstructor();

  final List<User> users = mockUsers;
  final List<Book> books = mockBooksWithoutCopies.map((book) {
    book.copies = mockCopies.where((copy) => copy.book.id == book.id).toList();
    return book;
  }).toList();

  /// References the singleton instance.
  static final LibrarySystem instance = LibrarySystem._privateConstructor();

  /// Prints a list of copies.
  static void _printCopies(List<Copy> copies) {
    String copiesText = "";

    for (Copy copy in copies) {
      copiesText = """$copiesText\n${copy.book.title}, exemplar ${copy.code},
              emprestado em ${copy.currentBorrow?.borrowDate} com prazo para ${copy.currentBorrow?.returnDate}""";
    }
    print(copiesText);
  }

  User? getUserById(String userId) =>
      users.firstWhereOrNull((element) => element.id == userId);

  Book? getBookById(String bookId) =>
      books.firstWhereOrNull((element) => element.id == bookId);

  /// Returns a list containing every late book a given User's possesion. This list does NOT return
  /// every book rented, only those that considered late.
  List<Copy>? getLateDebtsByUserId(String userId) {
    List<Copy> lateCopiesForUser = [];

    for (Book book in books) {
      for (Copy copy in book.borrowedCopies) {
        if (copy.currentBorrow != null) {
          Borrow borrow = copy.currentBorrow!;
          if (borrow.isLate && borrow.user.id == userId) {
            lateCopiesForUser = [...lateCopiesForUser, copy];
          }
        }
      }
    }

    if (lateCopiesForUser.isNotEmpty) {
      return lateCopiesForUser;
    }

    return null;
  }

  List<Book> getCurrentBorrowedBooksByUserId(String userId) {
    try {
      List<Book> borrowedBooks = books
          .where((element) => element.borrowedCopies
              .where((copy) => copy.currentBorrow?.user.id == userId)
              .isNotEmpty)
          .toList();
      return borrowedBooks;
    } catch (exception) {
      print(exception);
      return [];
    }
  }

  List<Book> getCurrentReservedBooksByUserId(String userId) {
    try {
      List<Book> reservations = books
          .where((element) => element.reservations
              .where((reservation) => reservation.user.id == userId)
              .isNotEmpty)
          .toList();
      return reservations;
    } catch (exception) {
      print(exception);
      return [];
    }
  }

  /// Lends a [Book] to an [User] according to its internal [BorrowStrategy].
  /// Returns a `bool` based on whether the borrow process was successful
  bool lendBookToUser(Book book, User user) {
    try {
      BorrowStrategy strategy = user.borrowStrategy;

      if (!book.hasAvailableCopies) {
        throw Exception(
            "Operação Negada. O livro ${book.title} está com todos os seus exemplares atualmente emprestados.");
      }

      if (!book.wasReservedByUserId(user.id) &&
          !strategy.canBypassReservations &&
          (book.reservationCount >= book.availableCopiesAmount)) {
        throw Exception(
            "Operação Negada. O livro ${book.title} está atualmente reservado apenas para usuários que reservaram anteriormente.");
      }

      List<Copy>? lateDebts = getLateDebtsByUserId(user.id);

      if (lateDebts != null && lateDebts.isNotEmpty) {
        _printCopies(lateDebts);
        throw Exception(
            "Operação Negada. ${user.name} possui ${lateDebts.length} exemplares em atraso. Para mais informações, consulte a lista acima");
      }

      if (getCurrentBorrowedBooksByUserId(user.id).length >=
          (strategy.borrowLimit ?? double.infinity)) {
        throw Exception(
            "Operação Negada. ${user.name} alcançou o limite de ${strategy.borrowLimit} empréstimos em paralelo");
      }

      if (book.wasBorrowedByUserId(user.id) && !strategy.canBorrowDuplicates) {
        throw Exception(
            "Operação Negada. ${user.name} possui um empréstimo do mesmo livro em andamento.");
      }

      DateTime dueDate = DateTime.now().add(strategy.borrowDuration);
      Borrow borrow = Borrow(user, book, DateTime.now(), dueDate);

      if (book.userReservation(user.id) != null) {
        book.reservations = book.reservations
            .where((element) => element.user.id != user.id)
            .toList();
      }
      book.availableCopies[0].currentBorrow = borrow;
      user.borrowHistory = [...user.borrowHistory, borrow];
      print(
          "Operação Sucedida. O livro emprestado deve ser devolvido até $dueDate");
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  /// Returns a [Book] associated with an [User]
  /// Returns a `bool` based on whether the reservation process was successful
  bool returnBook(Book book, User user) {
    try {
      Copy? borrowedCopy = book.borrowedCopies.firstWhereOrNull(
          (element) => element.currentBorrow?.user.id == user.id);

      if (borrowedCopy == null) {
        throw Exception(
            "Nenhum exemplar para o livro ${book.title} foi emprestado a ${user.name}");
      }

      borrowedCopy.currentBorrow = null;

      print("Operação Sucedida. O livro foi devolvido com sucesso");
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  /// Reserves a [Book] to an [User] according to its internal [BorrowStrategy]
  /// Returns a `bool` based on whether the reservation process was successful
  bool reserveBookToUser(Book book, User user) {
    try {
      BorrowStrategy strategy = user.borrowStrategy;

      if ((strategy.borrowLimit != null) &&
          getCurrentReservedBooksByUserId(user.id).length >= 3) {
        throw Exception(
            "Operação Negada. ${user.name} alcançou o limite de 3 reservas em paralelo");
      }

      if (book.wasReservedByUserId(user.id) && !strategy.canBorrowDuplicates) {
        throw Exception(
            "Operação Negada. ${user.name} já possui uma reserva para o mesmo livro.");
      }

      Reservation newReservation = Reservation(user, book, DateTime.now());

      book.reservations = [...book.reservations, newReservation];
      print(
          "Operação Sucedida. O livro informado pode ser reservado com prioridade.");
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  void printUserInfo(User user) {
    List<Borrow> borrows = user.borrowHistory;
    List<Book> reservations = getCurrentReservedBooksByUserId(user.id);
  }
}
