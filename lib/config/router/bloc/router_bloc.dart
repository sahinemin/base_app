import 'package:base_app/config/router/router.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

part 'router_event.dart';
part 'router_state.dart';
part 'route_config_navigation_command.dart';

@injectable
class RouterBloc extends Bloc<RouterEvent, RouterState> {
  RouterBloc(this._appRouter) : super(RouterInitial(_appRouter.routerConfig)) {
    on<NavigateWithRouterConfig>(_onNavigateWithRouterConfig);
  }

  void _onNavigateWithRouterConfig(
    NavigateWithRouterConfig event,
    Emitter<RouterState> emit,
  ) {
    event.command.execute(
      _appRouter.routerConfig,
      event.location,
      extra: event.extra,
    );
  }

  final AppRouter _appRouter;
}
