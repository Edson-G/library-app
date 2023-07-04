import 'package:library_app/books/borrow.dart';

class Copy {
  final int code;
  final int bookCode;
  Borrow? currentBorrow;

  Copy(
    this.code,
    this.bookCode,
  );

  bool get isAvaliable {
    if ((currentBorrow?.book == null) ||
        (currentBorrow?.user == null) ||
        (currentBorrow?.returnDate == null)) {
      return true;
    } else {
      return currentBorrow?.returnDate.isBefore(DateTime.now()) ?? false;
    }
  }

  String get status => isAvaliable ? "Disponível" : "Emprestado";
}
