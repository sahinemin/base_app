import 'package:base_app/core/error/failures.dart';
import 'package:base_app/features/todo/domain/entities/todo.dart';
import 'package:base_app/features/todo/domain/repositories/todo_repository_port.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTodoByIdUseCase {
  GetTodoByIdUseCase(this.repository);
  final TodoRepositoryPort repository;

  /// Retrieves a single Todo item by its ID.
  Future<Either<Failure, Todo>> call(int id) async {
    return repository.getTodoById(id);
  }
}
