import 'package:base_app/config/router/routes.dart';
import 'package:flutter/material.dart';

final class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            const HomeRoute().push<void>(context);
          },
          icon: const Icon(Icons.home),
          label: const Text('Home'),
        ),
      ),
    );
  }
}
