import 'package:base_app/config/router/base_route.dart';
import 'package:base_app/features/home/presentation/pages/home_page.dart';
import 'package:base_app/features/settings/presentation/pages/settings_page.dart';
import 'package:base_app/features/shared/pages/base_page_with_bottom_bar.dart';
import 'package:base_app/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';
part 'route_definitions.dart';

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

final class HomeRoute extends GoRouteData {
  const HomeRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

final class SettingsRoute extends GoRouteData {
  const SettingsRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsPage();
}
