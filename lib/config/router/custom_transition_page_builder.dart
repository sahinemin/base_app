import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class CustomTransitionPageBuilder {
  static Page<void> build({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    const transitionDuration = Durations.long1;
    return CustomTransitionPage<void>(
      key: state.pageKey,
      name: state.name,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final isPopping = animation.status == AnimationStatus.reverse;
        if (isPopping) {
          return FadeTransition(opacity: animation, child: child);
        } else {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }
      },
      transitionDuration: transitionDuration,
      reverseTransitionDuration: transitionDuration,
    );
  }
}
