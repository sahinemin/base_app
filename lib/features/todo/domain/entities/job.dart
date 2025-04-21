import 'package:base_app/core/error/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:fpdart/fpdart.dart';

/// Value Object for the Todo's job description.
/// Ensures the job string is not empty.
///
@immutable
final class Job extends Equatable {
  // Private constructor to enforce validation through the factory
  const Job._(this.value);
  final String value;

  /// Factory method to create a JobVO.
  /// Returns Either\<Failure, JobVO> to handle validation.
  static Either<Failure, Job> create(String value) {
    if (value.trim().isEmpty) {
      return left(
        const ValidationFailure(
          field: 'job',
          detailMessage: 'Job cannot be empty.',
        ),
      );
    }
    // Add other validation rules if needed (e.g., max length)
    return right(Job._(value));
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}
