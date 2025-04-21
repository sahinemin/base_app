import 'package:base_app/core/error/failures.dart';
import 'package:base_app/features/todo/domain/entities/todo.dart';
import 'package:fpdart/fpdart.dart';

/// Defines the contract for Todo data operations.
/// Implementations of this interface will handle the actual data fetching/persistence.
abstract class TodoRepositoryPort {
  /// Retrieves all Todo items.
  Future<Either<Failure, List<Todo>>> getAllTodos();

  /// Retrieves a single Todo item by its ID.
  Future<Either<Failure, Todo>> getTodoById(int id);

  /// Adds a new Todo item.
  /// Returns the ID of the newly created Todo on success.
  Future<Either<Failure, int>> addTodo(Todo todo);

  /// Updates an existing Todo item.
  Future<Either<Failure, void>> updateTodo(Todo todo);

  /// Deletes a Todo item by its ID.
  Future<Either<Failure, void>> deleteTodo(int id);

  /// Watches all Todo items for changes.
  /// Returns a stream that emits the list of Todos whenever data changes.
  Stream<Either<Failure, List<Todo>>> watchAllTodos();
}
