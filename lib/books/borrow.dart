import 'package:library_app/books/book.dart';
import 'package:library_app/users/user.dart';

class Borrow {
  final User user;
  final Book book;
  final DateTime borrowDate;
  final DateTime returnDeadline;
  DateTime? returnDate;
  bool isReturned = false;

  bool get isLate => isReturned && returnDeadline.isBefore(DateTime.now());

  Borrow(this.user, this.book, this.borrowDate, this.returnDeadline);
}
