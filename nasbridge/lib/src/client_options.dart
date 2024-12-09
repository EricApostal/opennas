import 'package:logging/logging.dart';
import 'package:nasbridge/src/plugin/plugin.dart';

/// Options for controlling the behavior of a [Nasbridge] client.
abstract class ClientOptions {
  /// The plugins to use for this client.
  final List<NasbridgePlugin> plugins;

  /// The name of the logger to use for this client.
  final String loggerName;

  /// The host where the TrueNAS server is located
  final String host;

  /// Whether to verify SSL certificates
  final bool verifySsl;

  /// The logger to use for this client.
  Logger get logger => Logger(loggerName);

  /// Create a new [ClientOptions].
  const ClientOptions({
    this.plugins = const [],
    this.loggerName = 'Nasbridge',
    this.host = 'localhost',
    this.verifySsl = true,
  });
}

/// Options for controlling the behavior of a [NasbridgeRest] client.
class RestClientOptions extends ClientOptions {
  /// The timeout duration for REST requests
  final Duration timeout;

  /// Create a new [RestClientOptions].
  const RestClientOptions({
    super.plugins,
    super.loggerName,
    super.host,
    super.verifySsl,
    this.timeout = const Duration(seconds: 30),
  });
}

/// Options for controlling the behavior of a [NasbridgeGateway] client.
class GatewayClientOptions extends RestClientOptions {
  /// The number of reconnection attempts to make before giving up
  final int maxReconnectAttempts;

  /// The delay between reconnection attempts
  final Duration reconnectDelay;

  /// Whether to automatically reconnect on disconnection
  final bool autoReconnect;

  /// Create a new [GatewayClientOptions].
  const GatewayClientOptions({
    super.plugins,
    super.loggerName,
    super.host,
    super.verifySsl,
    super.timeout,
    this.maxReconnectAttempts = 5,
    this.reconnectDelay = const Duration(seconds: 5),
    this.autoReconnect = true,
  });
}
