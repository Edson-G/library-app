import 'package:library_app/strategies/borrow/borrow_strategy.dart';
import 'package:library_app/books/book.dart';
import 'package:library_app/users/teacher.dart';
import 'package:library_app/users/user.dart';

class TeacherBorrowStrategy extends BorrowStrategy {
  @override
  Duration get borrowDuration => const Duration(days: 7);

  @override
  Null get borrowLimit => null;

  @override
  bool canBorrow(User user, Book book) {
    if (user is! Teacher) {
      return false;
    }

    return true;
  }
}
