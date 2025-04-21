import 'package:base_app/core/error/failures.dart';
import 'package:base_app/features/todo/domain/entities/todo.dart';
import 'package:base_app/features/todo/domain/repositories/todo_repository_port.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllTodosUseCase {
  GetAllTodosUseCase(this.repository);
  final TodoRepositoryPort repository;

  /// Retrieves all Todo items.
  Future<Either<Failure, List<Todo>>> call() async {
    return repository.getAllTodos();
  }
}
