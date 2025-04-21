// Needed for SqliteException
import 'package:base_app/core/error/exceptions.dart'; // Correct import path
import 'package:base_app/core/infrastructure/database/app_database.dart'
    show TodoDao, TodosCompanion;
import 'package:base_app/features/todo/infrastructure/datasources/todo_local_data_source.dart';
import 'package:base_app/features/todo/infrastructure/models/todo_dto.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:sqlite3/common.dart' show SqliteException;

/// Concrete implementation of [TodoLocalDataSource] using Drift.
@LazySingleton(as: TodoLocalDataSource)
class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  TodoLocalDataSourceImpl({required this.todoDao});
  final TodoDao todoDao;

  @override
  Future<List<TodoDto>> getAllTodos() async {
    try {
      return await todoDao.getAllTodos();
    } on SqliteException catch (e) {
      // Use SqliteException
      // Log the error e if needed
      throw CacheException(
        message: 'Failed to load todos from cache: ${e.message}',
      );
    } catch (e) {
      throw CacheException(
        message: 'An unexpected error occurred accessing cache: $e',
      );
    }
  }

  @override
  Stream<List<TodoDto>> watchAllTodos() {
    // Drift streams handle their own errors,
    //often emitting an error event on the stream.
    // The repository layer will need to handle stream errors.
    return todoDao.watchAllTodos();
  }

  @override
  Future<TodoDto?> getTodoById(int id) async {
    try {
      return await todoDao.getTodoById(id);
    } on SqliteException catch (e) {
      // Use SqliteException
      throw CacheException(
        message: 'Failed to load todo $id from cache: ${e.message}',
      );
    } catch (e) {
      throw CacheException(
        message: 'An unexpected error occurred accessing cache: $e',
      );
    }
  }

  @override
  Future<int> addTodo(TodoDto todo) async {
    try {
      // Convert TodoData to companion for insertion
      final companion = TodosCompanion.insert(
        // id is auto-increment
        createdAt: todo.createdAt, // Pass directly
        job: todo.job, // Pass directly
        createdBy: todo.createdBy, // Pass directly
        priority: todo.priority, // Pass directly
        // Use Value() for nullable or default fields if setting them
        expirationDate: Value(todo.expirationDate),
        isCompleted: Value(todo.isCompleted),
      );
      return await todoDao.insertTodo(companion);
    } on SqliteException catch (e) {
      throw CacheException(
        message: 'Failed to save todo to cache: ${e.message}',
      );
    } catch (e) {
      throw CacheException(
        message: 'An unexpected error occurred saving to cache: $e',
      );
    }
  }

  @override
  Future<bool> updateTodo(TodoDto todo) async {
    try {
      // Convert TodoData to companion for
      //update - use Value() for all fields being updated
      final companion = TodosCompanion(
        id: Value(todo.id),
        createdAt: Value(todo.createdAt),
        job: Value(todo.job),
        createdBy: Value(todo.createdBy),
        expirationDate: Value(todo.expirationDate),
        priority: Value(todo.priority),
        isCompleted: Value(todo.isCompleted),
      );
      return await todoDao.updateTodo(companion);
    } on SqliteException catch (e) {
      throw CacheException(
        message: 'Failed to update todo in cache: ${e.message}',
      );
    } catch (e) {
      throw CacheException(
        message: 'An unexpected error occurred updating cache: $e',
      );
    }
  }

  @override
  Future<void> deleteTodo(int id) async {
    try {
      await todoDao.deleteTodo(id);
      // Removed count check for simplicity, delete is idempotent
    } on SqliteException catch (e) {
      // Use SqliteException
      throw CacheException(
        message: 'Failed to delete todo $id from cache: ${e.message}',
      );
    } catch (e) {
      throw CacheException(
        message: 'An unexpected error occurred deleting from cache: $e',
      );
    }
  }
}
