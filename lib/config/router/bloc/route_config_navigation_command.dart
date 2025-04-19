part of 'router_bloc.dart';

sealed class RouterConfigNavigationCommand {
  const RouterConfigNavigationCommand();

  void execute(GoRouter router, String location, {Object? extra});
}

final class GoCommand extends RouterConfigNavigationCommand {
  const GoCommand();

  @override
  void execute(GoRouter router, String location, {Object? extra}) {
    router.go(location, extra: extra);
  }
}

final class PushCommand extends RouterConfigNavigationCommand {
  const PushCommand();

  @override
  void execute(GoRouter router, String location, {Object? extra}) {
    router.push(location, extra: extra);
  }
}

final class ReplaceCommand extends RouterConfigNavigationCommand {
  const ReplaceCommand();

  @override
  void execute(GoRouter router, String location, {Object? extra}) {
    router.replace<void>(location, extra: extra);
  }
}

final class PushReplacementCommand extends RouterConfigNavigationCommand {
  const PushReplacementCommand();

  @override
  void execute(GoRouter router, String location, {Object? extra}) {
    router.pushReplacement(location, extra: extra);
  }
}
