import 'package:base_app/config/router/bloc/router_bloc.dart';
import 'package:base_app/core/di/injection.dart';
import 'package:base_app/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>  getIt<RouterBloc>(),
      child: BlocBuilder<RouterBloc, RouterState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: state.router,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
