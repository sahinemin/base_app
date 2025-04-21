import 'package:base_app/features/todo/domain/entities/priority.dart';
import 'package:base_app/features/todo/infrastructure/datasources/local/tables.dart'; // Import feature table
import 'package:base_app/features/todo/infrastructure/models/todo_dto.dart';
import 'package:drift/drift.dart';

part 'app_database.g.dart'; // Generated file in this directory
part '../../../features/todo/infrastructure/datasources/local/todo_dao.dart';
// Add other feature table/DAO imports here if needed

@DriftDatabase(
  tables: [
    Todos, // List all tables from included features
    // SettingsTable, // Example for another feature
  ],
  daos: [
    TodoDao, // List all DAOs from included features
    // SettingsDao, // Example for another feature
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  // If using feature-specific DAOs, they are accessed via getters generated
  // in the _$AppDatabase mixin (e.g., this.todoDao)

  @override
  int get schemaVersion => 1;
}
