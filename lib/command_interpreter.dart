import 'package:library_app/books/book.dart';
import 'package:library_app/library_system.dart';
import 'package:library_app/users/user.dart';

class CommandInterpreter {
  /// Creates a [LibrarySystem] singleton.
  CommandInterpreter._privateConstructor();

  /// References the singleton instance.
  static final CommandInterpreter instance =
      CommandInterpreter._privateConstructor();

  final LibrarySystem system = LibrarySystem.instance;

  void interpretCommand(String command) {
    List<String> commandParts = command.split(' ');
    String action = commandParts[0];

    switch (action) {
      case 'emp':
        _processLoanCommand(commandParts);
        break;
      // case 'dev':
      //   _processReturnCommand(commandParts);
      //   break;
      // case 'res':
      //   _processReservationCommand(commandParts);
      //   break;
      // case 'obs':
      //   _processObserverCommand(commandParts);
      //   break;
      case 'liv':
        _processBookInfoCommand(commandParts);
        break;
      // case 'usu':
      //   _processUserInfoCommand(commandParts);
      //   break;
      // case 'ntf':
      //   _processNotificationCommand(commandParts);
      //   break;
      default:
        print('Comando inválido!');
    }
  }

  void _processLoanCommand(List<String> commandParts) {
    User? user = system.getUserById(commandParts[1]);
    Book? book = system.getBookById(commandParts[2]);

    if (user != null && book != null) {
      system.lendBookToUser(book, user);
      print('Empréstimo realizado com sucesso!');
    } else {
      print('Falha ao realizar empréstimo!');
    }
  }

  // void _processReturnCommand(List<String> commandParts) {
  //   // Extrair informações do comando
  //   String userId = commandParts[1];
  //   String bookId = commandParts[2];

  //   // Chamar o método de devolução na classe LibrarySystem
  //   bool success = system.returnBook(userId, bookId);

  //   if (success) {
  //     print('Devolução realizada com sucesso!');
  //   } else {
  //     print('Falha ao realizar devolução!');
  //   }
  // }

  // void _processReservationCommand(List<String> commandParts) {
  //   // Extrair informações do comando
  //   String userId = commandParts[1];
  //   String bookId = commandParts[2];

  //   // Chamar o método de reserva na classe LibrarySystem
  //   bool success = system.reserveBook(userId, bookId);

  //   if (success) {
  //     print('Reserva realizada com sucesso!');
  //   } else {
  //     print('Falha ao realizar reserva!');
  //   }
  // }

  // void _processObserverCommand(List<String> commandParts) {
  //   // Extrair informações do comando
  //   String userId = commandParts[1];
  //   String bookId = commandParts[2];

  //   // Chamar o método de registro de observador na classe LibrarySystem
  //   system.registerObserver(userId, bookId);
  //   print('Professor registrado como observador do livro!');
  // }

  void _processBookInfoCommand(List<String> commandParts) {
    String bookId = commandParts[1];
    Book? book = system.getBookById(bookId);

    if (book != null) {
      book.getBookInfo();
    }
    else {
      print('Esse livro não existe');
    }
  }

  // void _processUserInfoCommand(List<String> commandParts) {
  //   // Extrair informações do comando
  //   String userId = commandParts[1];

  //   // Chamar o método de obtenção de informações do usuário na classe LibrarySystem
  //   String userInfo = system.getUserInfo(userId);

  //   print(userInfo);
  // }

  // void _processNotificationCommand(List<String> commandParts) {
  //   // Extrair informações do comando
  //   String userId = commandParts[1];

  //   // Chamar o método de obtenção de notificações do professor na classe LibrarySystem
  //   int notificationCount = system.getNotificationCount(userId);

  //   print('Quantidade de notificações: $notificationCount');
  // }
}
