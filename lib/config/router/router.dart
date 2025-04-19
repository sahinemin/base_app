import 'package:base_app/config/router/custom_transition_page_builder.dart';
import 'package:base_app/config/router/routes.dart';
import 'package:base_app/features/error/presentation/pages/error_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

part '../observers/app_router_observer.dart';

@injectable
final class AppRouter {
  AppRouter(this._routerObserver);

  final NavigatorObserver _routerObserver;

  static final _rootNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'root',
  );


  late final routerConfig = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteDefinitions.initialRoute,
    errorPageBuilder:
        (context, state) => CustomTransitionPageBuilder.build(
          context: context,
          state: state,
          child: const ErrorPage(),
        ),
    debugLogDiagnostics: kDebugMode,
    routes: $appRoutes,
    observers: [_routerObserver],
  );
}
