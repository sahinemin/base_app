import 'package:base_app/core/error/failures.dart';
import 'package:base_app/features/todo/domain/entities/todo.dart';
import 'package:base_app/features/todo/domain/repositories/todo_repository_port.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddTodoUseCase {
  AddTodoUseCase(this.repository);
  final TodoRepositoryPort repository;

  /// Adds a new Todo item.
  /// Takes a domain [Todo] entity as input
  /// (which should be created via Todo.createNew).
  /// Returns the ID of the newly created Todo on success.
  Future<Either<Failure, int>> call(Todo todo) async {
    // In a real app, you might add more logic here, like checking permissions,
    // validating input beyond the entity level
    //, or coordinating multiple repositories.
    return repository.addTodo(todo);
  }
}
