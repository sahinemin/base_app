import 'package:base_app/core/error/failures.dart';
import 'package:base_app/features/todo/domain/entities/todo.dart';
import 'package:base_app/features/todo/domain/repositories/todo_repository_port.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class WatchAllTodosUseCase {
  WatchAllTodosUseCase(this.repository);
  final TodoRepositoryPort repository;

  /// Watches all Todo items for changes.
  /// Returns a stream that emits
  /// Either\<Failure, List\<Todo\>\> whenever data changes.
  Stream<Either<Failure, List<Todo>>> call() {
    return repository.watchAllTodos();
  }
}
