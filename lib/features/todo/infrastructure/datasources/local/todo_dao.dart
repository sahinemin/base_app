part of '../../../../../core/infrastructure/database/app_database.dart';

@DriftAccessor(tables: [Todos])
class TodoDao extends DatabaseAccessor<AppDatabase> with _$TodoDaoMixin {
  // Gets the AppDatabase instance via constructor injection (from DI)
  TodoDao(super.attachedDatabase);

  // Define common database operations here
  Future<List<TodoDto>> getAllTodos() => select(todos).get();
  Stream<List<TodoDto>> watchAllTodos() => select(todos).watch();
  Future<TodoDto?> getTodoById(int id) =>
      (select(todos)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  Future<int> insertTodo(Insertable<TodoDto> todo) => into(todos).insert(todo);
  Future<bool> updateTodo(Insertable<TodoDto> todo) =>
      update(todos).replace(todo);
  Future<int> deleteTodo(int id) =>
      (delete(todos)..where((tbl) => tbl.id.equals(id))).go();

  Future<bool> todoExists(int id) async {
    final query =
        select(todos)
          ..where((tbl) => tbl.id.equals(id))
          ..limit(1);
    // Execute the query.
    final result = await query.get();
    // If the result list is not empty, a matching row exists.
    return result.isNotEmpty;
  }
}
