import 'package:base_app/features/todo/infrastructure/models/todo_dto.dart'; // Import TodoData DTO

/// Abstract interface for the local data source handling Todo persistence.
abstract class TodoLocalDataSource {
  Future<List<TodoDto>> getAllTodos();
  Stream<List<TodoDto>> watchAllTodos();
  Future<TodoDto?> getTodoById(int id);
  Future<int> addTodo(TodoDto todo); // Takes DTO
  Future<bool> updateTodo(TodoDto todo); // Takes DTO
  Future<void> deleteTodo(int id);
}
