import 'package:base_app/core/error/exceptions.dart';
import 'package:base_app/core/error/failures.dart';
import 'package:base_app/features/todo/domain/entities/created_by.dart';
import 'package:base_app/features/todo/domain/entities/expiration_date.dart';
import 'package:base_app/features/todo/domain/entities/job.dart';
import 'package:base_app/features/todo/domain/entities/todo.dart';
import 'package:base_app/features/todo/domain/repositories/todo_repository_port.dart';
import 'package:base_app/features/todo/infrastructure/datasources/todo_local_data_source.dart';
import 'package:base_app/features/todo/infrastructure/models/todo_dto.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TodoRepositoryPort)
class TodoRepositoryAdapter implements TodoRepositoryPort {
  // If you had a remote data source, you'd inject it here too
  // final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryAdapter({required this.localDataSource});
  final TodoLocalDataSource localDataSource;

  @override
  Future<Either<Failure, int>> addTodo(Todo todo) async {
    try {
      // 1. Map Domain Entity (Todo) to DTO (TodoData)
      final todoData = _mapTodoToTodoData(todo);
      // 2. Call Datasource
      final newId = await localDataSource.addTodo(todoData);
      return Right(newId);
    } on CacheException catch (e) {
      return Left(CacheFailure(detailMessage: e.message));
    } on Exception catch (e) {
      // Handle unexpected errors
      return Left(
        CacheFailure(detailMessage: 'Unexpected error adding todo: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(int id) async {
    try {
      await localDataSource.deleteTodo(id);
      return const Right(null); // Use null for void success
    } on CacheException catch (e) {
      return Left(CacheFailure(detailMessage: e.message));
    } on Exception catch (e) {
      return Left(
        CacheFailure(detailMessage: 'Unexpected error deleting todo: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getAllTodos() async {
    try {
      final todoDataList = await localDataSource.getAllTodos();
      // Map List<TodoData> to List<Todo>
      final todosResult = _mapTodoDataListToTodoList(todoDataList);
      return todosResult;
    } on CacheException catch (e) {
      return Left(CacheFailure(detailMessage: e.message));
    } on Exception catch (e) {
      return Left(
        CacheFailure(detailMessage: 'Unexpected error getting all todos: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, Todo>> getTodoById(int id) async {
    try {
      final todoData = await localDataSource.getTodoById(id);
      if (todoData == null) {
        return Left(CacheFailure(detailMessage: 'Todo with id $id not found'));
      }
      // Map TodoData to Todo
      final todoResult = _mapTodoDataToTodo(todoData);
      return todoResult;
    } on CacheException catch (e) {
      return Left(CacheFailure(detailMessage: e.message));
    } on Exception catch (e) {
      return Left(
        CacheFailure(detailMessage: 'Unexpected error getting todo by id: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(Todo todo) async {
    try {
      final todoData = _mapTodoToTodoData(todo);
      await localDataSource.updateTodo(todoData);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(detailMessage: e.message));
    } on Exception catch (e) {
      return Left(
        CacheFailure(detailMessage: 'Unexpected error updating todo: $e'),
      );
    }
  }

  @override
  Stream<Either<Failure, List<Todo>>> watchAllTodos() {
    return localDataSource
        .watchAllTodos()
        .map(_mapTodoDataListToTodoList)
        .handleError((dynamic error) {
          // Handle errors on the stream
          if (error is CacheException) {
            return Left<Failure, List<Todo>>(
              CacheFailure(detailMessage: error.message),
            );
          } else {
            return Left<Failure, List<Todo>>(
              CacheFailure(detailMessage: 'Unexpected stream error: $error'),
            );
          }
        });
  }

  // --- Helper Mapping Functions ---

  /// Maps a single TodoData (DTO) to a Todo (Domain Entity).
  /// Includes Value Object creation and validation.
  Either<Failure, Todo> _mapTodoDataToTodo(TodoDto data) {
    final jobResult = Job.create(data.job);
    final createdByResult = CreatedBy.create(data.createdBy);
    final expirationDateResult = ExpirationDate.create(data.expirationDate);

    // Combine validation results
    return jobResult.flatMap((job) {
      return createdByResult.flatMap((createdBy) {
        return expirationDateResult.flatMap((expirationDate) {
          // Assuming data from DB is valid for other fields
          return Right(
            Todo(
              id: data.id,
              createdAt: data.createdAt,
              job: job,
              createdBy: createdBy,
              expirationDate: expirationDate,
              priority: data.priority,
              isCompleted: data.isCompleted,
            ),
          );
        });
      });
    });
  }

  /// Maps a list of TodoData (DTOs) to a list of Todo (Domain Entities).
  /// Collects failures if any mapping fails.
  Either<Failure, List<Todo>> _mapTodoDataListToTodoList(
    List<TodoDto> dataList,
  ) {
    final todos = <Todo>[];
    Failure? firstFailure;

    for (final data in dataList) {
      _mapTodoDataToTodo(data).fold((failure) {
        firstFailure ??= failure; // Store the first failure encountered
      }, todos.add,);
      // If a failure occurred, stop processing and return the failure
      if (firstFailure != null) {
        return Left(firstFailure!); // Or collect all failures if needed
      }
    }
    return Right(todos);
  }

  /// Maps a Todo (Domain Entity) to a TodoData (DTO).
  TodoDto _mapTodoToTodoData(Todo todo) {
    return TodoDto(
      id: todo.id,
      createdAt: todo.createdAt,
      job: todo.job.value, // Extract value from VO
      createdBy: todo.createdBy.value, // Extract value from VO
      expirationDate: todo.expirationDate.value, // Extract value from VO
      priority: todo.priority,
      isCompleted: todo.isCompleted,
    );
  }
}
