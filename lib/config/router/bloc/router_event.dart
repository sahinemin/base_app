part of 'router_bloc.dart';

sealed class RouterEvent extends Equatable {
  const RouterEvent();

  @override
  List<Object?> get props => [];
}

final class NavigateWithRouterConfig extends RouterEvent {
  const NavigateWithRouterConfig({
    required this.location,
    required this.command,
    this.extra,
  });

  final String location;
  final RouterConfigNavigationCommand command;
  final Object? extra;

  @override
  List<Object?> get props => [location, command, extra];
}
