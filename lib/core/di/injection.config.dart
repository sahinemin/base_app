// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:base_app/config/observers/app_bloc_observer.dart' as _i485;
import 'package:base_app/config/router/bloc/router_bloc.dart' as _i529;
import 'package:base_app/config/router/router.dart' as _i575;
import 'package:base_app/core/di/register_module.dart' as _i528;
import 'package:base_app/core/infrastructure/database/app_database.dart'
    as _i485;
import 'package:base_app/features/todo/application/usecases/add_todo_use_case.dart'
    as _i171;
import 'package:base_app/features/todo/application/usecases/delete_todo_use_case.dart'
    as _i464;
import 'package:base_app/features/todo/application/usecases/get_all_todos_use_case.dart'
    as _i675;
import 'package:base_app/features/todo/application/usecases/get_todo_by_id_use_case.dart'
    as _i992;
import 'package:base_app/features/todo/application/usecases/update_todo_use_case.dart'
    as _i284;
import 'package:base_app/features/todo/application/usecases/watch_all_todos_use_case.dart'
    as _i732;
import 'package:base_app/features/todo/domain/repositories/todo_repository_port.dart'
    as _i579;
import 'package:base_app/features/todo/infrastructure/datasources/todo_local_data_source.dart'
    as _i689;
import 'package:base_app/features/todo/infrastructure/datasources/todo_local_data_source_impl.dart'
    as _i74;
import 'package:base_app/features/todo/infrastructure/repositories/todo_repository_adapter.dart'
    as _i139;
import 'package:base_app/features/todo/presentation/bloc/todo_bloc.dart'
    as _i186;
import 'package:flutter/material.dart' as _i409;
import 'package:flutter_bloc/flutter_bloc.dart' as _i331;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i485.AppDatabase>(() => registerModule.appDatabase);
  gh.lazySingleton<_i485.TodoDao>(() => registerModule.todoDao);
  gh.lazySingleton<_i409.NavigatorObserver>(() => _i575.AppRouterObserver());
  gh.singleton<_i331.BlocObserver>(() => const _i485.AppBlocObserver());
  gh.factory<_i575.AppRouter>(
    () => _i575.AppRouter(gh<_i409.NavigatorObserver>()),
  );
  gh.factory<_i529.RouterBloc>(() => _i529.RouterBloc(gh<_i575.AppRouter>()));
  gh.lazySingleton<_i689.TodoLocalDataSource>(
    () => _i74.TodoLocalDataSourceImpl(todoDao: gh<_i485.TodoDao>()),
  );
  gh.lazySingleton<_i579.TodoRepositoryPort>(
    () => _i139.TodoRepositoryAdapter(
      localDataSource: gh<_i689.TodoLocalDataSource>(),
    ),
  );
  gh.factory<_i992.GetTodoByIdUseCase>(
    () => _i992.GetTodoByIdUseCase(gh<_i579.TodoRepositoryPort>()),
  );
  gh.factory<_i675.GetAllTodosUseCase>(
    () => _i675.GetAllTodosUseCase(gh<_i579.TodoRepositoryPort>()),
  );
  gh.factory<_i732.WatchAllTodosUseCase>(
    () => _i732.WatchAllTodosUseCase(gh<_i579.TodoRepositoryPort>()),
  );
  gh.factory<_i464.DeleteTodoUseCase>(
    () => _i464.DeleteTodoUseCase(gh<_i579.TodoRepositoryPort>()),
  );
  gh.factory<_i284.UpdateTodoUseCase>(
    () => _i284.UpdateTodoUseCase(gh<_i579.TodoRepositoryPort>()),
  );
  gh.factory<_i171.AddTodoUseCase>(
    () => _i171.AddTodoUseCase(gh<_i579.TodoRepositoryPort>()),
  );
  gh.factory<_i186.TodoBloc>(
    () => _i186.TodoBloc(
      getAllTodos: gh<_i675.GetAllTodosUseCase>(),
      getTodoById: gh<_i992.GetTodoByIdUseCase>(),
      addTodo: gh<_i171.AddTodoUseCase>(),
      updateTodo: gh<_i284.UpdateTodoUseCase>(),
      deleteTodo: gh<_i464.DeleteTodoUseCase>(),
      watchAllTodos: gh<_i732.WatchAllTodosUseCase>(),
    ),
  );
  return getIt;
}

class _$RegisterModule extends _i528.RegisterModule {}
