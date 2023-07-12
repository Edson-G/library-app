import 'package:library_app/books/book.dart';
import 'package:library_app/books/borrow.dart';

class Copy {
  final String code;
  final Book book;
  Borrow? currentBorrow;

  Copy(
    this.code,
    this.book,
  );

  bool get isAvailable {
    if ((currentBorrow == null) || (currentBorrow?.isReturned ?? false)) {
      currentBorrow = null;
      return true;
    } else {
      return false;
    }
  }

  String get status => isAvailable ? "Disponível" : "Emprestado";
}
