import 'package:library_app/books/book.dart';
import 'package:library_app/commands/library_command.dart';
import 'package:library_app/library_system.dart';
import 'package:library_app/users/user.dart';

class ReturnCommand implements LibraryCommand {
  @override
  bool execute(List<String> commandParts) {
    try {
      if (commandParts.isEmpty) {
        throw Exception(
            "Por favor, informe o id do usuário que realizará o devolução e o id do livro que será devolvido.");
      }

      if (commandParts.length < 2) {
        throw Exception("Por favor, informe o id do livro que será devolvido.");
      }

      if (commandParts.length > 2) {
        throw Exception("""Foram informados mais argumentos que o esperado. 
            Por favor, informe apenas o id do usuário que realizará a devolução e o id do livro que será devolvido.""");
      }

      final LibrarySystem system = LibrarySystem.instance;

      User? user = system.getUserById(commandParts[0]);
      if (user == null) {
        throw Exception("Não existe usuário com id ${commandParts[0]}");
      }

      Book? book = system.getBookById(commandParts[1]);
      if (book == null) {
        throw Exception("Não existe livro com id ${commandParts[1]}");
      }

      return system.returnBook(book, user);
    } catch (exception) {
      print(exception);
      return false;
    }
  }
}
