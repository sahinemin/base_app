import 'package:base_app/features/todo/domain/entities/priority.dart';
import 'package:base_app/features/todo/infrastructure/models/todo_dto.dart';
import 'package:drift/drift.dart';

// Define the converter for the Priority enum
class PriorityConverter extends TypeConverter<Priority, int> {
  const PriorityConverter();

  @override
  Priority fromSql(int fromDb) {
    return Priority.values[fromDb];
  }

  @override
  int toSql(Priority value) {
    return value.index;
  }
}

// Define the Drift table
@UseRowClass(TodoDto, constructor: 'fromDb')
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get job => text()(); // Corresponds to JobVO.value
  TextColumn get createdBy => text()(); // Corresponds to CreatedByVO.value
  DateTimeColumn get expirationDate =>
      dateTime().nullable()(); // Corresponds to ExpirationDate.value
  IntColumn get priority =>
      integer().map(const PriorityConverter())(); // Use the converter
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
}
