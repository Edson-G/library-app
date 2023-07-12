import 'package:library_app/strategies/borrow/borrow_strategy.dart';

class TeacherBorrowStrategy extends BorrowStrategy {
  @override
  Duration get borrowDuration => const Duration(days: 7);

  @override
  Null get borrowLimit => null;

  @override
  bool get canBorrowDuplicates => true;

  @override
  bool get canBypassReservations => true;
}
