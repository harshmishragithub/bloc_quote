/// Thrown by data sources when an API call fails.
class ServerException implements Exception {
  final String message;

  const ServerException(this.message);
}

