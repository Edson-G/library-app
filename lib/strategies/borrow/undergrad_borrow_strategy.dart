import 'package:library_app/books/borrow.dart';
import 'package:library_app/strategies/borrow/borrow_strategy.dart';
import 'package:library_app/books/book.dart';
import 'package:library_app/users/undergrad_student.dart';
import 'package:library_app/users/user.dart';

class UndergradBorrowStrategy extends BorrowStrategy {
  @override
  Duration get borrowDuration => const Duration(days: 3);

  @override
  int get borrowLimit => 3;

  @override
  bool canBorrow(User user, Book book) {
    if (user is! UndergradStudent) {
      return false;
    }

    // (i)
    if (book.availableCopies.isEmpty) {
      return false;
    }

    // (ii)
    if (book.borrowedCopies.where((element) {
      Borrow? borrow = element.currentBorrow;
      if (borrow == null) {
        return false;
      }
      return borrow.isLate && (borrow.user.code == user.code);
    }).isNotEmpty) {
      return false;
    }

    return true;
  }
}
