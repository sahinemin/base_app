import 'package:base_app/core/error/failures.dart';
import 'package:base_app/features/todo/domain/entities/todo.dart';
import 'package:base_app/features/todo/domain/repositories/todo_repository_port.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateTodoUseCase {

  UpdateTodoUseCase(this.repository);
  final TodoRepositoryPort repository;

  /// Updates an existing Todo item.
  /// Takes the updated [Todo] entity as input.
  /// Note: Ensure the ID of the passed Todo entity is correct.
  Future<Either<Failure, void>> call(Todo todo) async {
    // Add validation here if needed - e.g., 
    //check if todo.id is valid before sending
    // You might also perform validation 
    //on the fields if the entity itself doesn't cover all cases.
    return repository.updateTodo(todo);
  }
}
