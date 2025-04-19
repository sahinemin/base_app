import 'package:flutter/foundation.dart';

/// Abstract interface for an error logging service.
///
/// Implementations can send error reports to external services
/// like Sentry, Firebase Crashlytics, etc.
abstract class ErrorLoggingService {
  /// Logs an error or exception, potentially with additional context.
  Future<void> logError(
    dynamic error, {
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  });

  /// Logs a non-fatal message or warning.
  Future<void> logMessage(String message, {Map<String, dynamic>? context});
}

/// A basic implementation that logs errors to the debug console.
class ConsoleErrorLoggingService implements ErrorLoggingService {
  @override
  Future<void> logError(
    dynamic error, {
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) async {
    if (kDebugMode) {
      print('***** ERROR LOG *****');
      print('Error: $error');
      if (stackTrace != null) {
        print('StackTrace: $stackTrace');
      }
      if (context != null) {
        print('Context: $context');
      }
      print('*******************');
    }
    // In a real implementation, you would send this data to your logging service.
  }

  @override
  Future<void> logMessage(
    String message, {
    Map<String, dynamic>? context,
  }) async {
    if (kDebugMode) {
      print('----- MESSAGE LOG -----');
      print('Message: $message');
      if (context != null) {
        print('Context: $context');
      }
      print('---------------------');
    }
    // Optionally send non-fatal messages to your logging service.
  }
}
