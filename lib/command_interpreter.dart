import 'package:library_app/library_system.dart';

class CommandInterpreter {
  late LibrarySystem system;

  CommandInterpreter() {
    system = LibrarySystem.instance;
  }

  void interpretCommand(String command) {
    List<String> commandParts = command.split(' ');
    String action = commandParts[0];

    switch (action) {
      case 'emp':
        _processLoanCommand(commandParts);
        break;
      case 'dev':
        _processReturnCommand(commandParts);
        break;
      case 'res':
        _processReservationCommand(commandParts);
        break;
      case 'obs':
        _processObserverCommand(commandParts);
        break;
      case 'liv':
        _processBookInfoCommand(commandParts);
        break;
      case 'usu':
        _processUserInfoCommand(commandParts);
        break;
      case 'ntf':
        _processNotificationCommand(commandParts);
        break;
      case 'sai':
        _processExitCommand();
        break;
      default:
        print('Comando inválido!');
    }
  }

  void _processLoanCommand(List<String> commandParts) {
    // Extrair informações do comando
    String userId = commandParts[1];
    String bookId = commandParts[2];

    // Chamar o método de empréstimo na classe LibrarySystem
    bool success = system.lendBookToUser(book, user);

    if (success) {
      print('Empréstimo realizado com sucesso!');
    } else {
      print('Falha ao realizar empréstimo!');
    }
  }

  void _processReturnCommand(List<String> commandParts) {
    // Extrair informações do comando
    String userId = commandParts[1];
    String bookId = commandParts[2];

    // Chamar o método de devolução na classe LibrarySystem
    bool success = system.returnBook(userId, bookId);

    if (success) {
      print('Devolução realizada com sucesso!');
    } else {
      print('Falha ao realizar devolução!');
    }
  }

  void _processReservationCommand(List<String> commandParts) {
    // Extrair informações do comando
    String userId = commandParts[1];
    String bookId = commandParts[2];

    // Chamar o método de reserva na classe LibrarySystem
    bool success = system.reserveBook(userId, bookId);

    if (success) {
      print('Reserva realizada com sucesso!');
    } else {
      print('Falha ao realizar reserva!');
    }
  }

  void _processObserverCommand(List<String> commandParts) {
    // Extrair informações do comando
    String userId = commandParts[1];
    String bookId = commandParts[2];

    // Chamar o método de registro de observador na classe LibrarySystem
    system.registerObserver(userId, bookId);
    print('Professor registrado como observador do livro!');
  }

  void _processBookInfoCommand(List<String> commandParts) {
    // Extrair informações do comando
    String bookId = commandParts[1];

    // Chamar o método de obtenção de informações do livro na classe LibrarySystem
    String bookInfo = system.getBookInfo(bookId);

    print(bookInfo);
  }

  void _processUserInfoCommand(List<String> commandParts) {
    // Extrair informações do comando
    String userId = commandParts[1];

    // Chamar o método de obtenção de informações do usuário na classe LibrarySystem
    String userInfo = system.getUserInfo(userId);

    print(userInfo);
  }

  void _processNotificationCommand(List<String> commandParts) {
    // Extrair informações do comando
    String userId = commandParts[1];

    // Chamar o método de obtenção de notificações do professor na classe LibrarySystem
    int notificationCount = system.getNotificationCount(userId);

    print('Quantidade de notificações: $notificationCount');
  }

  void _processExitCommand() {
    // Finalizar o programa
    print('Saindo do sistema...');
    exit(0);
  }
}
