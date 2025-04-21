import 'package:base_app/core/error/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:fpdart/fpdart.dart';

/// Value Object for the Todo's creator identifier.
/// Ensures the creator string is not empty.
@immutable
final class CreatedBy extends Equatable {
  // Private constructor
  const CreatedBy._(this.value);
  final String value;

  /// Factory method to create a CreatedByVO.
  static Either<Failure, CreatedBy> create(String input) {
    if (input.trim().isEmpty) {
      return left(
        const ValidationFailure(
          field: 'createdBy',
          detailMessage: 'Creator cannot be empty.',
        ),
      );
    }
    return right(CreatedBy._(input));
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}
