import 'dart:async';
import 'dart:developer';

import 'package:base_app/core/di/injection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, BlocObserver;
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  // observes the bloc's states and events
  Bloc.observer = getIt<BlocObserver>();

  // removes the # in the route
  setPathUrlStrategy();

  // allows the route to be reflected in the URL
  GoRouter.optionURLReflectsImperativeAPIs = true;

  runApp(await builder());
}
