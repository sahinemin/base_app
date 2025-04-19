part of '../router/router.dart';

@LazySingleton(as: NavigatorObserver)
final class AppRouterObserver implements NavigatorObserver {
  final _navigationStack = <Route<dynamic>>[];

  String? _getRouteName(Route<dynamic>? route) {
    if (route == null) return null;

    final settings = route.settings;
    if (settings is Page) {
      return settings.name;
    }
    return settings.name;
  }

  void _logNavigation(
    String event,
    Route<dynamic>? current,
    Route<dynamic>? previous,
  ) {
    final currentName = _getRouteName(current);
    final previousName = _getRouteName(previous);

    debugPrint('''
    🚦 Navigation Event: $event
    └─ Current Route: $currentName
    └─ Previous Route: $previousName
    └─ Current Stack: ${_navigationStack.map((e) => e.settings.name).join(', ')}
    └─ Stack Size: ${_navigationStack.length}
    ''');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _navigationStack.add(route);
    _logNavigation('PUSH', route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _navigationStack.removeLast();
    _logNavigation('POP', previousRoute, route);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _navigationStack.remove(route);
    _logNavigation('REMOVE', previousRoute, route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (oldRoute != null) {
      final index = _navigationStack.indexOf(oldRoute);
      if (index != -1 && newRoute != null) {
        _navigationStack[index] = newRoute;
      }
    }
    _logNavigation('REPLACE', newRoute, oldRoute);
  }

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    _logNavigation('GESTURE_START', route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    debugPrint('🚦 Navigation Gesture: COMPLETED');
  }

  @override
  void didChangeTop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    return;
  }

  Route<dynamic>? get currentRoute => _navigationStack.lastOrNull;

  List<Route<dynamic>> get navigationHistory =>
      List.unmodifiable(_navigationStack);

  bool get canPop => _navigationStack.length > 1;

  @override
  NavigatorState? get navigator => _navigator;
  NavigatorState? _navigator;

  set navigator(NavigatorState? value) {
    _navigator = value;
    if (value == null) {
      _navigationStack.clear();
    }
  }
}
