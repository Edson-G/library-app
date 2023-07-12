import 'package:library_app/strategies/borrow/undergrad_borrow_strategy.dart';
import 'package:library_app/users/user.dart';

class UndergradStudent extends User {
  UndergradStudent(super.code, super.name);

  @override
  UndergradBorrowStrategy get borrowStrategy => UndergradBorrowStrategy();
}
