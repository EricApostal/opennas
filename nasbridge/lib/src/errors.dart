/// The base class for all exceptions thrown by Chloroplast.
class NasbridgeException implements Exception {
  /// The message for this exception.
  final String message;

  /// Create a new [NasbridgeException] with the provided [message].
  NasbridgeException(this.message);

  @override
  String toString() => message;
}

/// An error thrown when an issue with a client's plugin is encountered.
class PluginError extends Error {
  /// The message for this [PluginError].
  final String message;

  /// Create a new [PluginError].
  PluginError(this.message);

  @override
  String toString() => message;
}

class AuthenticationError implements Exception {
  final String message;
  AuthenticationError(this.message);

  @override
  String toString() => 'AuthenticationError: $message';
}
