part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];
}

/// Initial state, before anything is loaded.
final class TodoInitial extends TodoState {
  const TodoInitial();
}

/// State indicating that todos are being loaded.
final class TodoLoading extends TodoState {
  const TodoLoading();
}

/// State indicating todos have been successfully loaded.
final class TodoLoaded extends TodoState {
  const TodoLoaded(this.todos);
  final List<Todo> todos;

  @override
  List<Object> get props => [todos];
}

/// State indicating an error occurred.
final class TodoError extends TodoState {
  const TodoError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

/// State indicating a single todo has been successfully loaded.
final class TodoDetailLoaded extends TodoState {

  const TodoDetailLoaded(this.todo);
  final Todo todo;

  @override
  List<Object> get props => [todo];
}
