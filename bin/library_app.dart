import 'dart:convert';
import 'dart:io';

import 'package:library_app/command_interpreter.dart';

void main(List<String> arguments) {
  CommandInterpreter interpreter = CommandInterpreter.instance;
  while (true) {
    String line = stdin.readLineSync(encoding: utf8) ?? '';
    if (line == 'sai') {
      print('Saindo do sistema...');
      break;
    }
    interpreter.interpretCommand(line);
  }
}
