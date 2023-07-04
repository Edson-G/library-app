import 'package:library_app/books/book.dart';
import 'package:library_app/users/user.dart';

class Reservation {
  final User user;
  final Book book;
  final DateTime requestDate;

  const Reservation(this.user, this.book, this.requestDate);
}
