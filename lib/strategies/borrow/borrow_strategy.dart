/// Handles user specific business logic related to borrowing books.
abstract class BorrowStrategy {
  /// How long should a borrow last for.
  Duration get borrowDuration => throw UnimplementedError(
        "BorrowStrategy implementations should override borrowDuration",
      );

  /// How many books may stay in borrower's possession at a time. A `null` value
  /// will be interpreted as limitless, making it so that any amount of books can be
  /// in someon's possession as they need to.
  int? get borrowLimit => throw UnimplementedError(
        "BorrowStrategy implementations should override borrowLimit",
      );

  /// Whether a user can borrow multiple copies of the same book.
  bool get canBorrowDuplicates => throw UnimplementedError(
        "BorrowStrategy implementations should override canBorrowDuplicates",
      );

  /// Whether a user can bypass the reservations queue.
  bool get canBypassReservations => throw UnimplementedError(
        "BorrowStrategy implementations should override canBypassReservations",
      );
}
