import 'package:library_app/books/book.dart';
import 'package:library_app/users/user.dart';

/// Handles implementation specific business logic related to borrowing books.
abstract class BorrowStrategy {
  /// How long should a borrow last for.
  Duration get borrowDuration => throw UnimplementedError(
        "BorrowStrategy implementations should override BorrowDuration",
      );

  /// How many books may stay in borrower's possession at a time. A `null` value
  /// will be interpreted as limitless, making it so that any amount of books can be
  /// in someon's possession as they need to.
  int? get borrowLimit => throw UnimplementedError(
        "BorrowStrategy implementations should override BorrowlIMITBorrowLimit",
      );

  /// Whether a given [User] can borrow a given [Book].
  bool canBorrow(User user, Book book) {
    throw UnimplementedError(
      "BorrowStrategy implementations should override canBorrow()",
    );
  }
}
