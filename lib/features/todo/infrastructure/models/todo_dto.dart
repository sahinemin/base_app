// It's often useful to have a Drift-specific data class, especially if
// you need custom constructors or methods for DB interaction.
// Alternatively, you could try mapping directly
// to the Domain Entity if simple enough.
// This data class structure provides a clear separation.
import 'package:base_app/features/todo/domain/entities/priority.dart';

class TodoDto {
  TodoDto({
    required this.id,
    required this.createdAt,
    required this.job,
    required this.createdBy,
    required this.priority,
    required this.isCompleted,
    this.expirationDate,
  });

  // Factory constructor used by Drift's @UseRowClass
  factory TodoDto.fromDb({
    required int id,
    required DateTime createdAt,
    required String job,
    required String createdBy,
    required Priority priority,
    required bool isCompleted,
    DateTime? expirationDate,
  }) {
    return TodoDto(
      id: id,
      createdAt: createdAt,
      job: job,
      createdBy: createdBy,
      expirationDate: expirationDate,
      priority: priority,
      isCompleted: isCompleted,
    );
  }
  final int id;
  final DateTime createdAt;
  final String job;
  final String createdBy;
  final DateTime? expirationDate;
  final Priority priority;
  final bool isCompleted;
}
