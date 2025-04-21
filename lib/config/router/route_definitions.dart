part of 'routes.dart';

final class RouteDefinitions {
  static String get initialRoute => _splashPath;

  static List<RouteDefinitions> get authRoutes => [];

  static List<RouteDefinitions> get mainRoutes => [];

  static bool isAuthRoute(String path) => path.startsWith('');

  static bool isProtectedRoute(String path) =>
      !isAuthRoute(path) && path != initialRoute;

  static const _splashPath = '/';
  static const _splashName = 'splash';

  static const _homePath = '/home';
  static const _homeName = 'home';

  static const _settingsPath = '/settings';
  static const _settingsName = 'settings';

  static const _todoPath = '/todo';
  static const _todoName = 'todo';

  static const _todoDetailPath = ':todoId';
  static const _todoDetailName = 'todoDetail';
}
