import 'package:library_app/books/borrow.dart';
import 'package:library_app/books/copy.dart';
import 'package:library_app/books/reservation.dart';
import 'package:library_app/users/user.dart';

class Book {
  final String code;
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
      copies.where((copy) => !copy.isAvailable).toList();

  /// Every book [Copy] currently available for borrowing.
  List<Copy> get availableCopies =>
      copies.where((copy) => copy.isAvailable).toList();

  /// How many book copies are available for borrowin.
  int get availableCopiesAmount => availableCopies.length;

  /// Whether there is a book copy which can be borrowed currently.
  bool get hasAvailableCopies => availableCopies.isNotEmpty;

  void getBookInfo() {
    print("Título: $title");

    int reservationCount = reservations.length;
    print("Quantidade de reservas: $reservationCount");

    for (int i = 0; i < reservationCount; i++) {
      Reservation reservation = reservations[i];
      User user = reservation.user;
      print("Reserva ${i + 1}: ${user.name}");
    }

    for (Copy copy in copies) {
      String status = copy.isAvailable ? "Disponível" : "Emprestado";
      String loanInfo = "";

      if (!copy.isAvailable) {
        Borrow? borrow = copy.currentBorrow;
        User? user = borrow?.user;
        loanInfo = " - Empréstimo: ${user?.name} - Data de Empréstimo: ${borrow?.borrowDate} - Data de Devolução: ${borrow?.returnDeadline}";
      }

      print("Exemplar ${copy.code}: $status$loanInfo");
    }
  }
}
