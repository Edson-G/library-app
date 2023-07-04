import 'package:library_app/strategies/borrow/borrow_strategy.dart';
import 'package:library_app/books/book.dart';
import 'package:library_app/users/postgrad_student.dart';
import 'package:library_app/users/user.dart';

class PostgradBorrowStrategy extends BorrowStrategy {
  @override
  Duration get borrowDuration => Duration(days: 4);

  @override
  int get borrowLimit => 4;

  @override
  bool canBorrow(User user, Book book) {
    if (user is! PostgradStudent) {
      return false;
    }

    return true;
  }
}
