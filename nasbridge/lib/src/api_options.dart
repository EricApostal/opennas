/// Options for connecting to the TrueNAS API.
abstract class ApiOptions {
  /// The default value for the `User-Agent` header.
  static const defaultUserAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36';

  /// The base URI relative to the host where the API can be found.
  String get baseUri => '/api/v2.0';

  /// The value of the `User-Agent` header to send with each request.
  final String userAgent;

  /// The host at which the API can be found.
  final String host;

  /// Create a new [ApiOptions].
  ApiOptions({
    required this.host,
    this.userAgent = defaultUserAgent,
  });
}

/// Options for connecting to the TrueNAS API to make HTTP requests.
class RestApiOptions extends ApiOptions {
  /// The username to use for authentication.
  final String username;

  /// The password to use for authentication.
  final String password;

  /// Create a new [RestApiOptions].
  RestApiOptions({
    required this.username,
    required this.password,
    required super.host,
    super.userAgent,
  });
}

/// Options for connecting to the TrueNAS API for making HTTP requests and WebSocket connections.
class GatewayApiOptions extends RestApiOptions {
  /// The WebSocket protocol version to use.
  final String protocolVersion;

  /// The supported protocol versions.
  final List<String> supportedVersions;

  /// Create a new [GatewayApiOptions].
  GatewayApiOptions({
    required super.username,
    required super.password,
    required super.host,
    super.userAgent,
    this.protocolVersion = '1',
    this.supportedVersions = const ['1'],
  });

  /// Create the initial connect message for WebSocket handshake
  Map<String, dynamic> createConnectMessage() => {
        'msg': 'connect',
        'version': protocolVersion,
        'support': supportedVersions,
      };
}
