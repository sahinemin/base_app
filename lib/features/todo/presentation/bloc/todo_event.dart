part of 'todo_bloc.dart';

// Imports for Equatable, Priority, Todo are needed in the main BLoC file

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all todos.
final class LoadTodos extends TodoEvent {
  const LoadTodos();
}

/// Event to watch all todos for changes.
final class WatchTodosSubscription extends TodoEvent {
  const WatchTodosSubscription();
}

/// Event to add a new todo.
final class AddTodo extends TodoEvent {
  const AddTodo({
    required this.job,
    required this.createdBy,
    required this.priority,
    this.expirationDate,
  });
  final String job;
  final String createdBy;
  final Priority priority;
  final DateTime? expirationDate;

  @override
  List<Object?> get props => [job, createdBy, priority, expirationDate];
}

/// Event to update an existing todo (including toggling completion).
final class UpdateTodo extends TodoEvent {
  const UpdateTodo(this.updatedTodo);
  final Todo updatedTodo;

  @override
  List<Object> get props => [updatedTodo];
}

/// Event to delete a todo.
final class DeleteTodo extends TodoEvent {
  const DeleteTodo(this.id);
  final int id;

  @override
  List<Object> get props => [id];
}

/// Event to load a single todo by its ID.
final class LoadTodoById extends TodoEvent {

  const LoadTodoById(this.id);
  final int id;

  @override
  List<Object> get props => [id];
}
