import 'package:library_app/books/book.dart';
import 'package:library_app/commands/library_command.dart';
import 'package:library_app/library_system.dart';
import 'package:library_app/users/user.dart';

class UserInfoCommand implements LibraryCommand {
  @override
  bool execute(List<String> commandParts) {
    try {
      if (commandParts.isEmpty) {
        throw Exception(
            "Por favor, informe o id do usuário que deseja consultar.");
      }

      if (commandParts.length > 1) {
        throw Exception("""Foram informados mais argumentos que o esperado. 
            Por favor, informe apenas o id do usuário que deseja consultar.""");
      }

      String userId = commandParts[0];
      User? user = LibrarySystem.instance.getUserById(userId);

      if (user == null) {
        throw Exception(
            "Não é possível dar detalhes sobre o usuário $userId, pois não existe usuário com este id");
      }

      LibrarySystem.instance.printUserInfo(user);
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }
}
