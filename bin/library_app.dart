import 'package:library_app/library_system.dart';

void main(List<String> arguments) {
  LibrarySystem system = LibrarySystem.instance;
  print("Usuários registrados: ${system.users.length}");
  print("Livros registrados: ${system.books.length}");

  system.lendBookToUser(system.books[0], system.users[0]);
  print(
      "Considerando o catálogo atual, segue a quantidade de cópias para cada livro:");
  for (var element in system.books) {
    print(
        '${element.title}(${element.code}) possui ${element.copies.length} cópias');
  }
}
