import 'package:base_app/core/error/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

/// Value Object representing the Todo's expiration date.
class ExpirationDate extends Equatable {
  // Private constructor
  const ExpirationDate._(this.value);
  // Store the DateTime value, allowing null.
  final DateTime? value;

  /// Factory method to create an ExpirationDate.
  /// Currently, accepts any valid DateTime?.
  /// Future validation (e.g., checking if it's not too far in the past/future)
  /// could be added here.
  static Either<Failure, ExpirationDate> create(DateTime? input) {
    // Validation: Check if the date is in the future if provided
    if (input != null && !input.isAfter(DateTime.now())) {
      return left(
        const ValidationFailure(
          field: 'expirationDate',
          detailMessage: 'Expiration date must be in the future.',
        ),
      );
    }
    // If null or valid date, create the object
    return right(ExpirationDate._(input));
  }

  @override
  List<Object?> get props => [value];
  @override
  String toString() => value?.toIso8601String() ?? 'No Expiration';
}
