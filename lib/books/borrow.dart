import 'package:library_app/books/book.dart';
import 'package:library_app/users/user.dart';

class Borrow {
  final User user;
  final Book book;
  final DateTime borrowDate;
  final DateTime returnDate;

  const Borrow(this.user, this.book, this.borrowDate, this.returnDate);
}
