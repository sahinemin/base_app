import 'package:equatable/equatable.dart';

/// Represents a generic failure in the application.
///
/// Extend this class to create specific failure types.
abstract class Failure extends Equatable {
  // If you have properties common to all failures, add them here.
  // For example: final String message;
  // Failure([List properties = const <dynamic>[]]): super();

  const Failure();

  @override
  List<Object?> get props => [];

  // Optional: Add a helper method for user-friendly messages
  String get message => 'An unexpected error occurred.';
}

/// Represents a failure occurring during server interactions (e.g., API calls).
class ServerFailure extends Failure {
  const ServerFailure({this.detailMessage});
  final String? detailMessage;

  @override
  String get message =>
      detailMessage ?? 'A server error occurred. Please try again later.';

  @override
  List<Object?> get props => [detailMessage];
}

/// Represents a failure occurring during local
/// cache operations (e.g., SharedPreferences, Hive).
class CacheFailure extends Failure {
  const CacheFailure({this.detailMessage});
  final String? detailMessage;

  @override
  String get message => detailMessage ?? 'A cache error occurred.';

  @override
  List<Object?> get props => [detailMessage];
}

/// Represents a failure due to network connectivity issues.
class NetworkFailure extends Failure {
  const NetworkFailure({this.detailMessage});
  final String? detailMessage;

  @override
  String get message =>
      detailMessage ??
      'No internet connection detected. Please check your network.';

  @override
  List<Object?> get props => [detailMessage];
}

/// Represents a failure due to invalid input data.
class ValidationFailure extends Failure {
  const ValidationFailure({required this.field, this.detailMessage});
  final String field;
  final String? detailMessage;

  @override
  String get message => detailMessage ?? 'Invalid input for $field.';

  @override
  List<Object?> get props => [field, detailMessage];
}

// Add other specific failure types as needed
