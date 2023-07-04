import 'package:library_app/books/copy.dart';
import 'package:library_app/library_system.dart';

void main(List<String> arguments) {
  LibrarySystem system = LibrarySystem.instance;
  print("Usuários registrados: ${system.users.length}");
  print("Livros registrados: ${system.books.length}");

  print(
      "Considerando o catálogo atual, segue a quantidade de cópias para cada livro:");
  for (var element in system.books) {
    print(
        '${element.title}(${element.code}) possui ${element.copies.length} cópias');
  }

  system.lendBookToUser(system.books[0], system.users[0]);
  Copy borrowedBook = system.books[0].borrowedCopies[0];
  print(borrowedBook);
  print(
      """O usuário ${system.users[0].name} 
      está com o exemplar ${borrowedBook.currentBorrow?.book.title} 
      de id ${borrowedBook.bookCode} 
      até ${borrowedBook.currentBorrow?.returnDate}""");
}
