import 'package:collection/collection.dart';
import 'package:library_app/books/borrow.dart';
import 'package:library_app/books/copy.dart';
import 'package:library_app/books/reservation.dart';

class Book {
  final String id;
  final String title;
  final String publisher;
  final List<String> authors;
  final int edition;
  final int year;
  List<Copy> copies = [];
  List<Reservation> reservations = [];

  Book(
    this.id,
    this.title,
    this.publisher,
    this.authors,
    this.edition,
    this.year,
  );

  /// Every book [Copy] currently borrowed.
  List<Copy> get borrowedCopies => copies
      .where((copy) => !copy.isAvailable)
      .sorted((a, b) => (a.currentBorrow?.returnDeadline.isBefore(
                  b.currentBorrow?.returnDeadline ?? DateTime.now()) ??
              false)
          ? 1
          : -1)
      .toList();

  /// Every book [Copy] currently available for borrowing.
  List<Copy> get availableCopies =>
      copies.where((copy) => copy.isAvailable).toList();

  /// How many book copies are available for borrowin.
  int get availableCopiesAmount => availableCopies.length;

  /// Whether there is a book copy which can be borrowed currently.
  bool get hasAvailableCopies => availableCopies.isNotEmpty;

  /// How many book copies are available for borrowing.
  int get reservationCount => reservations.length;

  bool wasBorrowedByUserId(String userId) => borrowedCopies
      .where((copy) => copy.currentBorrow?.user.id == userId)
      .isNotEmpty;

  bool wasReservedByUserId(String userId) => reservations
      .where((reservation) => reservation.user.id == userId)
      .isNotEmpty;

  Reservation? userReservation(String userId) => reservations
      .firstWhereOrNull((reservation) => reservation.user.id == userId);

  void printBookInfo() {
    print("Título: $title");

    print("Quantidade de reservas: $reservationCount");

    for (var element in reservations
        .sorted((a, b) => a.requestDate.isBefore(b.requestDate) ? 1 : -1)) {
      print("- ${element.user.name}, reservado em ${element.requestDate}");
    }

    for (Copy element in copies) {
      String loanInfo = "";

      if (element.currentBorrow != null) {
        Borrow borrow = element.currentBorrow!;
        loanInfo =
            " - Na posse de: ${borrow.user.name} - Data de Empréstimo: ${borrow.borrowDate} - Prazo de Devolução: ${borrow.returnDeadline}";
      }

      print("Exemplar ${element.code}: ${element.status}$loanInfo");
    }
  }
}
