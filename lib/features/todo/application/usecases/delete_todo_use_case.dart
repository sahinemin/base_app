import 'package:base_app/core/error/failures.dart';
import 'package:base_app/features/todo/domain/repositories/todo_repository_port.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteTodoUseCase {
  DeleteTodoUseCase(this.repository);
  final TodoRepositoryPort repository;

  /// Deletes a Todo item by its ID.
  Future<Either<Failure, void>> call(int id) {
    return repository.deleteTodo(id);
  }
}
