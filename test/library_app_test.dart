import 'package:library_app/library_system.dart';
import 'package:test/test.dart';

void main() {
  test('creates a LibrarySystem singleton', () {
    final libraryA = LibrarySystem.instance;
    final libraryB = LibrarySystem.instance;
    expect(libraryA, libraryB);
  });
}
