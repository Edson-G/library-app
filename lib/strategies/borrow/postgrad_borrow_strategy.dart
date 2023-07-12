import 'package:library_app/strategies/borrow/borrow_strategy.dart';

class PostgradBorrowStrategy extends BorrowStrategy {
  @override
  Duration get borrowDuration => Duration(days: 4);

  @override
  int get borrowLimit => 4;

  @override
  bool get canBorrowDuplicates => false;

  @override
  bool get canBypassReservations => false;
}
