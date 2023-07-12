abstract class LibraryCommand {
  bool execute(List<String> commandParts) {
    throw UnimplementedError("LibraryCommand instances must override execute");
  }
}
