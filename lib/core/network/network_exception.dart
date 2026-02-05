import 'package:http/http.dart' as http;

/// Thrown when a request fails due to connectivity (socket, DNS, timeout, etc.).
class NetworkException implements Exception {
  NetworkException([this.message = 'Network not available', this.cause]);

  /// User-facing message for the UI.
  final String message;

  /// Original exception, if any (for logging or debugging).
  final Object? cause;

  @override
  String toString() => message;

  /// Builds a [NetworkException] from a caught [error] with a consistent message.
  static NetworkException from(Object error) {
    if (error is NetworkException) return error;
    return NetworkException('Network not available', error);
  }
}

/// Returns true if [error] is a client/connection error (e.g. SocketException,
/// ClientException, timeout, no internet).
bool isNetworkError(Object error) {
  if (error is NetworkException) return true;
  if (error is http.ClientException) return true;
  final msg = error.toString().toLowerCase();
  return msg.contains('socket') ||
      msg.contains('connection refused') ||
      msg.contains('network is unreachable') ||
      msg.contains('failed host lookup') ||
      msg.contains('connection reset') ||
      msg.contains('timed out') ||
      msg.contains('connection closed');
}
