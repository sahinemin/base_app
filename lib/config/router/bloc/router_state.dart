part of 'router_bloc.dart';

sealed class RouterState extends Equatable {
  const RouterState(this.router);

  final GoRouter router;

  @override
  List<Object?> get props => [router];
}

final class RouterInitial extends RouterState {
  const RouterInitial(super.router);
}
