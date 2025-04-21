import 'dart:async';

import 'package:base_app/core/error/failures.dart';
import 'package:base_app/features/todo/application/usecases/add_todo_use_case.dart';
import 'package:base_app/features/todo/application/usecases/delete_todo_use_case.dart';
import 'package:base_app/features/todo/application/usecases/get_all_todos_use_case.dart';
import 'package:base_app/features/todo/application/usecases/get_todo_by_id_use_case.dart';
import 'package:base_app/features/todo/application/usecases/update_todo_use_case.dart';
import 'package:base_app/features/todo/application/usecases/watch_all_todos_use_case.dart';
import 'package:base_app/features/todo/domain/entities/priority.dart';
import 'package:base_app/features/todo/domain/entities/todo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

part 'todo_event.dart';
part 'todo_state.dart';

@injectable
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({
    required GetAllTodosUseCase getAllTodos,
    required GetTodoByIdUseCase getTodoById,
    required AddTodoUseCase addTodo,
    required UpdateTodoUseCase updateTodo,
    required DeleteTodoUseCase deleteTodo,
    required WatchAllTodosUseCase watchAllTodos,
  }) : _getAllTodos = getAllTodos,
       _getTodoById = getTodoById,
       _addTodo = addTodo,
       _updateTodo = updateTodo,
       _deleteTodo = deleteTodo,
       _watchAllTodos = watchAllTodos,
       super(const TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<LoadTodoById>(_onLoadTodoById);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<WatchTodosSubscription>(_onWatchTodosSubscription);
  }
  final GetAllTodosUseCase _getAllTodos;
  final GetTodoByIdUseCase _getTodoById;
  final AddTodoUseCase _addTodo;
  final UpdateTodoUseCase _updateTodo;
  final DeleteTodoUseCase _deleteTodo;
  final WatchAllTodosUseCase _watchAllTodos;

  StreamSubscription<Either<Failure, List<Todo>>>? _todoSubscription;

  @override
  Future<void> close() {
    _todoSubscription?.cancel();
    return super.close();
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(const TodoLoading());
    final result = await _getAllTodos();
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (todos) => emit(TodoLoaded(todos)),
    );
  }

  Future<void> _onLoadTodoById(
    LoadTodoById event,
    Emitter<TodoState> emit,
  ) async {
    emit(const TodoLoading());
    final result = await _getTodoById(event.id);
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (todo) => emit(TodoDetailLoaded(todo)),
    );
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    // Create the domain entity first, performing validation
    final newTodoEither = Todo.createNew(
      jobInput: event.job,
      createdByInput: event.createdBy,
      priority: event.priority,
      expirationDateInput: event.expirationDate,
    );

    await newTodoEither.fold(
      (failure) async {
        // Emit error if validation fails
        final previousState = state;
        emit(TodoError(failure.message));
        // Consider re-emitting previous loaded state if available
        if (previousState is TodoLoaded) {
          emit(TodoLoaded(previousState.todos));
        }
      },
      (newTodo) async {
        // If entity creation is successful, call the use case
        final result = await _addTodo(newTodo);
        result.fold(
          (failure) {
            emit(TodoError(failure.message));
            // Consider re-emitting previous loaded state if available
            if (state is TodoLoaded) {
              emit(TodoLoaded((state as TodoLoaded).todos));
            }
          },
          (newId) {
            // Optionally trigger a reload or rely on the watcher
            // For simplicity here, we don't emit a new state immediately
            // assuming the watcher will update the list.
            // If not using watcher, you might call _getAllTodos again:
            // add(const LoadTodos());
          },
        );
      },
    );
  }

  Future<void> _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) async {
    // Optimistic update can be done here by emitting TodoLoaded immediately
    // before awaiting the result, but for simplicity, we wait.
    final result = await _updateTodo(event.updatedTodo);
    result.fold(
      (failure) {
        emit(TodoError(failure.message));
        if (state is TodoLoaded) {
          emit(TodoLoaded((state as TodoLoaded).todos));
        }
      },
      (_) {
        // Optionally trigger reload or rely on watcher
        // add(const LoadTodos());
      },
    );
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    final result = await _deleteTodo(event.id);
    result.fold(
      (failure) {
        emit(TodoError(failure.message));
        if (state is TodoLoaded) {
          emit(TodoLoaded((state as TodoLoaded).todos));
        }
      },
      (_) {
        // Optionally trigger reload or rely on watcher
        // add(const LoadTodos());
      },
    );
  }

  Future<void> _onWatchTodosSubscription(
    WatchTodosSubscription event,
    Emitter<TodoState> emit,
  ) async {
    emit(const TodoLoading());
    await _todoSubscription?.cancel();

    await emit.onEach(
      _watchAllTodos(),
      onData: (eitherResult) {
        eitherResult.fold(
          (failure) => emit(TodoError(failure.message)),
          (todos) => emit(TodoLoaded(todos)),
        );
      },
      onError: (error, stackTrace) => emit(TodoError(error.toString())),
    );
  }
}
