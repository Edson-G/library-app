import 'package:library_app/books/copy.dart';
import 'package:library_app/books/reservation.dart';

class Book {
  final int code;
  final String title;
  final String publisher;
  final List<String> authors;
  final int edition;
  final int year;
  List<Copy> copies = [];
  List<Reservation> reservations = [];

  Book(
    this.code,
    this.title,
    this.publisher,
    this.authors,
    this.edition,
    this.year,
  );

  /// Every book [Copy] currently borrowed.
  List<Copy> get borrowedCopies =>
      copies.where((copy) => !copy.isAvaliable).toList();

  /// Every book [Copy] currently available for borrowing.
  List<Copy> get availableCopies =>
      copies.where((copy) => copy.isAvaliable).toList();

  /// How many book copies are available for borrowin.
  int get availableCopiesAmount => availableCopies.length;

  /// Whether there is a book copy which can be borrowed currently.
  bool get hasAvailableCopies => availableCopies.isNotEmpty;
}
