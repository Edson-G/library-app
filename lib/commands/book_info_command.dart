import 'package:library_app/books/book.dart';
import 'package:library_app/commands/library_command.dart';
import 'package:library_app/library_system.dart';

class BookInfoCommand implements LibraryCommand {
  @override
  bool execute(List<String> commandParts) {
    try {
      if (commandParts.isEmpty) {
        throw Exception("Por favor, informe o id do livro que deseja buscar.");
      }

      if (commandParts.length > 1) {
        throw Exception("""Foram informados mais argumentos que o esperado. 
            Por favor, informe apenas o id do livro que deseja buscar.""");
      }

      String bookId = commandParts[0];
      Book? book = LibrarySystem.instance.getBookById(bookId);

      if (book == null) {
        throw Exception(
            "Não é possível dar detalhes sobre o livro $bookId, pois não existe livro com este id");
      }

      book.printBookInfo();
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }
}
