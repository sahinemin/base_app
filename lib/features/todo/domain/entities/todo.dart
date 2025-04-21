import 'package:base_app/core/error/failures.dart';
import 'package:base_app/features/todo/domain/entities/created_by.dart';
import 'package:base_app/features/todo/domain/entities/expiration_date.dart';
import 'package:base_app/features/todo/domain/entities/job.dart';
import 'package:base_app/features/todo/domain/entities/priority.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart'; // Generated file

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required int id,
    required DateTime createdAt,
    required Job job,
    required CreatedBy createdBy,
    required Priority priority,
    required ExpirationDate expirationDate,
    @Default(false) bool isCompleted,
  }) = _Todo;
  // Private constructor for freezed. Data fields are defined here.
  const Todo._();


  /// Factory method to create a validated Todo entity.
  /// Use this for creating NEW todos where ID is not yet known
  /// and validation needs to occur.
  static Either<Failure, Todo> createNew({
    required String jobInput,
    required String createdByInput,
    required Priority priority,
    DateTime? expirationDateInput,
  }) {
    // 1. Validate Value Objects sequentially using flatMap
    return Job.create(jobInput).flatMap((jobVO) {
      return CreatedBy.create(createdByInput).flatMap((createdByVO) {
        return ExpirationDate.create(expirationDateInput).flatMap((
          expirationDate,
        ) {
          final now = DateTime.now();
          // Create the entity
          return right(
            Todo(
              id: -1, // Placeholder ID
              createdAt: now,
              job: jobVO,
              createdBy: createdByVO,
              expirationDate: expirationDate,
              priority: priority,
            ),
          );
        });
      });
    });
  }

  bool get isDue {
    final expValue = expirationDate.value; // Access value
    // If value is null, it's not due. Otherwise, check if it's before now.
    return expValue != null && expValue.isBefore(DateTime.now());
  }
}
