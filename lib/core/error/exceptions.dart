/// Represents a generic exception occurring during data source interactions.
class DatasourceException implements Exception {
  final String? message;
  DatasourceException({this.message});

  @override
  String toString() =>
      'DatasourceException: ${message ?? "An unknown datasource error occurred"}';
}

/// Exception specifically for server-related errors (e.g., API errors, 5xx status codes).
class ServerException extends DatasourceException {
  final int? statusCode;
  ServerException({super.message, this.statusCode});

  @override
  String toString() =>
      'ServerException: ${message ?? "Server error"}${statusCode != null ? " (Status code: $statusCode)" : ""}';
}

/// Exception specifically for cache-related errors (e.g., failed read/write to local storage).
class CacheException extends DatasourceException {
  CacheException({super.message});

  @override
  String toString() => 'CacheException: ${message ?? "Cache error"}';
}

/// Exception specifically for network connectivity issues encountered by datasources.
class NetworkException extends DatasourceException {
  NetworkException({super.message});

  @override
  String toString() => 'NetworkException: ${message ?? "Network error"}';
}

/// Exception for authorization/authentication errors from a datasource.
class AuthorizationException extends DatasourceException {
  AuthorizationException({super.message});

  @override
  String toString() =>
      'AuthorizationException: ${message ?? "Authorization failed"}';
}

// Add other specific exception types as needed.
