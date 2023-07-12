import 'package:library_app/strategies/borrow/borrow_strategy.dart';

class UndergradBorrowStrategy extends BorrowStrategy {
  @override
  Duration get borrowDuration => const Duration(days: 3);

  @override
  int get borrowLimit => 3;

  @override
  bool get canBorrowDuplicates => false;

  @override
  bool get canBypassReservations => false;
}
