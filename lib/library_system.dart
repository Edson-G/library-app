import 'package:library_app/books/borrow.dart';
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

  User? getUserById(String userId) {
    for (User user in users) {
      if (user.code == userId) {
        return user;
      }
    }
    return null;
  }

  Book? getBookById(String bookId) {
    for (Book book in books) {
      if (book.code == bookId) {
        return book;
      }
    }
    return null;
  }

  final List<User> users = mockUsers;
  final List<Book> books = mockBooks.map((book) {
    book.copies =
        mockCopies.where((copy) => copy.bookCode == book.code).toList();
    return book;
  }).toList();
}
