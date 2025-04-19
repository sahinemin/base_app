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
import 'package:flutter/material.dart' as _i409;
import 'package:flutter_bloc/flutter_bloc.dart' as _i331;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i409.NavigatorObserver>(() => _i575.AppRouterObserver());
    gh.singleton<_i331.BlocObserver>(() => const _i485.AppBlocObserver());
    gh.factory<_i575.AppRouter>(
      () => _i575.AppRouter(gh<_i409.NavigatorObserver>()),
    );
    gh.factory<_i529.RouterBloc>(() => _i529.RouterBloc(gh<_i575.AppRouter>()));
    return this;
  }
}
