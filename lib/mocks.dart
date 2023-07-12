import 'package:library_app/books/book.dart';
import 'package:library_app/books/copy.dart';
import 'package:library_app/users/postgrad_student.dart';
import 'package:library_app/users/teacher.dart';
import 'package:library_app/users/undergrad_student.dart';
import 'package:library_app/users/user.dart';

List<User> mockUsers = [
  UndergradStudent('123', 'João da Silva'),
  PostgradStudent('456', 'Luiz Fernando Rodrigues'),
  UndergradStudent('789', 'Pedro Paulo'),
  Teacher('100', 'Carlos Lucena'),
];

List<Book> mockBooksWithoutCopies = [
  Book(
    '100',
    "Engenharia de Software",
    "AddisonWesley",
    ["Ian Sommervile"],
    6,
    2000,
  ),
  Book(
    '101',
    "UML - Guia do Usuário",
    "Campus",
    ["Grady Booch", "James Rambaugh", "Ivar Jacobson"],
    7,
    2000,
  ),
  Book(
    '200',
    "Code Complete",
    "Microsoft Press",
    ["Steve McConnell"],
    2,
    2014,
  ),
  Book(
    '201',
    "Agile Software Development, Principles, Patterns and Practices",
    "Prentice Hall",
    ["Robert Martin"],
    1,
    2002,
  ),
  Book(
    '300',
    "Refactoring: Improvind the Design of Existing Code",
    "Addison-Wesley Professional",
    ["Martin Fowler"],
    1,
    1999,
  ),
  Book(
    '301',
    "Software Metrics: A Rigorous and Practical Approach",
    "CRC Press",
    ["Norman Fenton", "James Bieman"],
    3,
    2014,
  ),
  Book(
    '400',
    "Design Pattterns: Elements of Reusable Object-Oriented Software",
    "Addison-Wesley Professional",
    ["Enrich Gamma", "Richard Helm", "Ralph Johnson", "John Vlissides"],
    1,
    1994,
  ),
  Book(
    '401',
    "UML Distilled: A Brief Guide to the Standard Object Modeling Language",
    "Addison-Wesley Professional",
    ["Martin Fowler"],
    3,
    2003,
  ),
];
List<Copy> mockCopies = [
  Copy('01', mockBooksWithoutCopies[0]),
  Copy('02', mockBooksWithoutCopies[0]),
  Copy('03', mockBooksWithoutCopies[1]),
  Copy('04', mockBooksWithoutCopies[2]),
  Copy('05', mockBooksWithoutCopies[3]),
  Copy('06', mockBooksWithoutCopies[4]),
  Copy('07', mockBooksWithoutCopies[4]),
  Copy('08', mockBooksWithoutCopies[6]),
  Copy('09', mockBooksWithoutCopies[6]),
];
