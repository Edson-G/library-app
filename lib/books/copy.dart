import 'package:library_app/books/borrow.dart';

class Copy {
  final int code;
  final int bookCode;
  Borrow? currentBorrow;

  Copy(
    this.code,
    this.bookCode,
  );

  bool get isAvailable {
    if ((currentBorrow?.book == null) ||
        (currentBorrow?.user == null) ||
        (currentBorrow?.returnDate == null)) {
      currentBorrow = null;
      return true;
    } else {
      return false;
    }
  }

  String get status => isAvailable ? "Disponível" : "Emprestado";
}
