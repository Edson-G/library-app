import 'package:library_app/strategies/borrow/postgrad_borrow_strategy.dart';
import 'package:library_app/users/user.dart';

class PostgradStudent extends User {
  PostgradStudent(super.code, super.name);

  @override
  PostgradBorrowStrategy get borrowStrategy => PostgradBorrowStrategy();
}
