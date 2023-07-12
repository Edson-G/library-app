import 'package:library_app/strategies/borrow/teacher_borrow_strategy.dart';
import 'package:library_app/users/user.dart';

class Teacher extends User {
  Teacher(super.code, super.name);

  @override
  TeacherBorrowStrategy get borrowStrategy => TeacherBorrowStrategy();
}
