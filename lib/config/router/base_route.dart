import 'package:base_app/config/router/custom_transition_page_builder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class BaseRoute extends GoRouteData {
  const BaseRoute();

  @override
  Widget build(BuildContext context, GoRouterState state);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPageBuilder.build(
      context: context,
      state: state,
      child: build(context, state),
    );
  }
}
