import 'package:library_app/books/borrow.dart';
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

  /// References the singleton instance.
  static final LibrarySystem instance = LibrarySystem._privateConstructor();

  /// Lends a [Book] to a [User] according to its internal [BorrowStrategy]
  bool lendBookToUser(Book book, User user) {
    try {
      BorrowStrategy strategy = user.borrowStrategy;

      if (strategy.canBorrow(user, book)) {
        DateTime dueDate = DateTime.now().add(strategy.borrowDuration);
        Borrow borrow = Borrow(user, book, DateTime.now(), dueDate);
        book.availableCopies[0].currentBorrow = borrow;
        return true;
      }
    } catch (error) {
      print(error);
      return false;
    }
    return false;
  }

  /// Reservers a [Book] to a [User] according to its internal [ReserveStrategy]
  bool reserveBookToUser(Book book, User user) {
    // TODO: Implement
    throw UnimplementedError();
  }

  User getUserById(String userId) {
    try {
      for (User user in users) {
        if (user.code == userId) {
          return user;
        }
      }
      throw Exception("Não existe usuário com o id $userId");
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Book getBookById(String bookId) {
    try {
      for (Book book in books) {
        if (book.code == bookId) {
          return book;
        }
      }
      throw Exception("Não existe livro com o id $bookId");
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  List<Borrow> getBorrowsByUserId(String? id) {
    try {
      final Iterable<Borrow> foundBorrows = borrows.where(
        (element) => element.user.code == id,
      );

      if (foundBorrows.isEmpty) {
        throw Exception(
          "Nenhum empréstimo encontrado para o usuário de id $id",
        );
      }

      return foundBorrows.toList();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  List<Borrow> getBorrowsByBookId(String? id) {
    try {
      final Iterable<Borrow> foundBorrows = borrows.where(
        (element) => element.book.code == id,
      );

      if (foundBorrows.isEmpty) {
        throw Exception(
          "Nenhum empréstimo encontrado para o livro de id $id",
        );
      }

      return foundBorrows.toList();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  List<Reservation> getReservationsByUserId(String? id) {
    try {
      final Iterable<Reservation> foundReservations = reservations.where(
        (element) => element.user.code == id,
      );

      if (foundReservations.isEmpty) {
        throw Exception(
          "Nenhum empréstimo encontrado para o usuário de id $id",
        );
      }

      return foundReservations.toList();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  List<Reservation> getReservationsByBookId(String? id) {
    try {
      final Iterable<Reservation> foundReservations = reservations.where(
        (element) => element.book.code == id,
      );

      if (foundReservations.isEmpty) {
        throw Exception(
          "Nenhum empréstimo encontrado para o livro de id $id",
        );
      }

      return foundReservations.toList();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  final List<User> users = mockUsers;
  final List<Book> books = mockBooks.map((book) {
    book.copies =
        mockCopies.where((copy) => copy.bookCode == book.code).toList();
    return book;
  }).toList();
  final List<Borrow> borrows = [];
  final List<Reservation> reservations = [];
}
