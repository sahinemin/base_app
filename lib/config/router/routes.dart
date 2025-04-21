import 'package:base_app/config/router/base_route.dart';
import 'package:base_app/core/presentation/pages/base_page_with_bottom_bar.dart';
import 'package:base_app/core/presentation/splash/presentation/pages/splash_page.dart';
import 'package:base_app/features/home/presentation/pages/home_page.dart';
import 'package:base_app/features/settings/presentation/pages/settings_page.dart';
import 'package:base_app/features/todo/presentation/pages/todo_detail_page.dart';
import 'package:base_app/features/todo/presentation/pages/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'route_definitions.dart';
part 'routes.g.dart';

@TypedGoRoute<SplashRoute>(
  path: RouteDefinitions._splashPath,
  name: RouteDefinitions._splashName,
)
final class SplashRoute extends BaseRoute {
  const SplashRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashPage();
}

@TypedStatefulShellRoute<CustomShellRoute>(
  branches: <TypedStatefulShellBranch>[
    TypedStatefulShellBranch<HomeBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeRoute>(
          path: RouteDefinitions._homePath,
          name: RouteDefinitions._homeName,
        ),
      ],
    ),
    TypedStatefulShellBranch<SettingsBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SettingsRoute>(
          path: RouteDefinitions._settingsPath,
          name: RouteDefinitions._settingsName,
        ),
      ],
    ),
    TypedStatefulShellBranch<TodoBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<TodoRoute>(
          path: RouteDefinitions._todoPath,
          name: RouteDefinitions._todoName,
          routes: <TypedRoute<RouteData>>[
            TypedGoRoute<TodoDetailRoute>(
              path: RouteDefinitions._todoDetailPath,
              name: RouteDefinitions._todoDetailName,
            ),
          ],
        ),
      ],
    ),
  ],
)
final class CustomShellRoute extends StatefulShellRouteData {
  static final $navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');
  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return BasePageWithBottomBar(child: navigationShell);
  }
}

final class HomeBranch extends StatefulShellBranchData {
  const HomeBranch();
}

final class SettingsBranch extends StatefulShellBranchData {
  const SettingsBranch();
}

final class TodoBranch extends StatefulShellBranchData {
  const TodoBranch();
}

final class HomeRoute extends GoRouteData {
  const HomeRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

final class TodoRoute extends GoRouteData {
  const TodoRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const TodoPage();
}

final class TodoDetailRoute extends GoRouteData {
  const TodoDetailRoute({required this.todoId});
  final int todoId;
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      TodoDetailPage(todoId: todoId);
}

final class SettingsRoute extends GoRouteData {
  const SettingsRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsPage();
}
