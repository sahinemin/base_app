// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$splashRoute, $customShellRoute];

RouteBase get $splashRoute => GoRouteData.$route(
  path: '/',
  name: 'splash',

  factory: $SplashRouteExtension._fromState,
);

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  String get location => GoRouteData.$location('/');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $customShellRoute => StatefulShellRouteData.$route(
  factory: $CustomShellRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/home',
          name: 'home',

          factory: $HomeRouteExtension._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/settings',
          name: 'settings',

          factory: $SettingsRouteExtension._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/todo',
          name: 'todo',

          factory: $TodoRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: ':todoId',
              name: 'todoDetail',

              factory: $TodoDetailRouteExtension._fromState,
            ),
          ],
        ),
      ],
    ),
  ],
);

extension $CustomShellRouteExtension on CustomShellRoute {
  static CustomShellRoute _fromState(GoRouterState state) => CustomShellRoute();
}

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location('/home');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsRouteExtension on SettingsRoute {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  String get location => GoRouteData.$location('/settings');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TodoRouteExtension on TodoRoute {
  static TodoRoute _fromState(GoRouterState state) => const TodoRoute();

  String get location => GoRouteData.$location('/todo');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TodoDetailRouteExtension on TodoDetailRoute {
  static TodoDetailRoute _fromState(GoRouterState state) =>
      TodoDetailRoute(todoId: int.parse(state.pathParameters['todoId']!));

  String get location =>
      GoRouteData.$location('/todo/${Uri.encodeComponent(todoId.toString())}');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
