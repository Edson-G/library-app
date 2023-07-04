import 'dart:convert';
import 'dart:io';

import 'package:library_app/books/copy.dart';
import 'package:library_app/command_interpreter.dart';
import 'package:library_app/library_system.dart';

void main(List<String> arguments) {
  LibrarySystem system = LibrarySystem.instance;
  CommandInterpreter commandInterpreter = CommandInterpreter();
  while (true) {
    String line = stdin.readLineSync(encoding: utf8) ?? '';
    if (line == 'sai') {
      print('Saindo do sistema...');
      break;
    }
    commandInterpreter.interpretCommand(line);
  }
}
