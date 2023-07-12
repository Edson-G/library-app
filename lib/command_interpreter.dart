import 'package:library_app/commands/book_info_command.dart';
import 'package:library_app/commands/library_command.dart';
import 'package:library_app/commands/loan_command.dart';
import 'package:library_app/commands/reserve_command.dart';
import 'package:library_app/commands/return_command.dart';
import 'package:library_app/library_system.dart';

class CommandInterpreter {
  /// Creates a [LibrarySystem] singleton.
  CommandInterpreter._privateConstructor();

  /// References the singleton instance.
  static final CommandInterpreter instance =
      CommandInterpreter._privateConstructor();

  void interpretCommand(String command) {
    List<String> commandParts = command.trim().split(' ');
    String action = commandParts[0];

    Map<String, LibraryCommand> commandByAction = {
      'emp': LoanCommand(),
      'dev': ReturnCommand(),
      'liv': BookInfoCommand(),
      'res': ReserveCommand(),
    };

    try {
      if (commandByAction[action] == null) {
        throw Exception(
            "Comando inexistente. Por referência, os comandos existentes são ${commandByAction.keys}");
      }
      commandByAction[action]?.execute(commandParts.skip(1).toList());
    } catch (exception) {
      print(exception);
    }

    // case 'res':
    //   _processReservationCommand(commandParts);
    //   break;
    // case 'obs':
    //   _processObserverCommand(commandParts);
    //   break;
    // case 'usu':
    //   _processUserInfoCommand(commandParts);
    //   break;
    // case 'ntf':
    //   _processNotificationCommand(commandParts);
    //   break;
  }
}
