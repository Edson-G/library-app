import 'package:library_app/books/borrow.dart';
import 'package:library_app/strategies/borrow/borrow_strategy.dart';

abstract class User {
  final String id;
  final String name;
  List<Borrow> borrowHistory = [];

  User(this.id, this.name);

  BorrowStrategy get borrowStrategy;
}
