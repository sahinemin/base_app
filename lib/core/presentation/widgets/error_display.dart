import 'package:base_app/core/error/failures.dart';
import 'package:flutter/material.dart';

/// A generic widget to display error messages based on a Failure.
class ErrorDisplay extends StatelessWidget {

  const ErrorDisplay({required this.failure, super.key, this.onRetry});
  final Failure failure;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              failure.message, // Use the message from the Failure object
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            if (onRetry != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: onRetry,
                  child: const Text('Retry'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
