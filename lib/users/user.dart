import 'package:library_app/strategies/borrow/borrow_strategy.dart';

abstract class User {
  final String code;
  final String name;

  const User(this.code, this.name);

  BorrowStrategy get borrowStrategy;
}
