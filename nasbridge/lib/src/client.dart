import 'dart:async';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:nasbridge/src/api_options.dart';
import 'package:nasbridge/src/client_options.dart';
import 'package:nasbridge/src/errors.dart';
import 'package:nasbridge/src/event_mixin.dart';
import 'package:nasbridge/src/gateway/gateway.dart';
import 'package:nasbridge/src/http/handler.dart';
import 'package:nasbridge/src/plugin/plugin.dart';
import 'package:runtime_type/runtime_type.dart';

/// Helper function to handle plugin connections
Future<T> _doConnect<T extends Nasbridge>(
    ApiOptions apiOptions,
    ClientOptions clientOptions,
    Future<T> Function() connect,
    List<NasbridgePlugin> plugins) {
  final actualClientType = RuntimeType<T>();

  for (final plugin in plugins) {
    if (!actualClientType.isSubtypeOf(plugin.clientType)) {
      throw PluginError(
          'Unsupported client type: plugin needs ${plugin.clientType.internalType}, client was ${actualClientType.internalType}');
    }
  }

  final originalConnect = connect;

  connect = plugins.fold(
    () async => await originalConnect()
      .._initializedCompleter.complete(),
    (previousConnect, plugin) => () async => actualClientType.castInstance(
        await plugin.doConnect(apiOptions, clientOptions, previousConnect)),
  );

  return connect();
}

/// Helper function to handle plugin closures
Future<void> _doClose(Nasbridge client, Future<void> Function() close,
    List<NasbridgePlugin> plugins) {
  close = plugins.fold(
    close,
    (previousClose, plugin) => () => plugin.doClose(client, previousClose),
  );
  return close();
}

@internal
extension InternalReady on Nasbridge {
  @internal
  Future<void> get initialized => _initializedCompleter.future;
}

/// Base class for TrueNAS API clients
abstract class Nasbridge {
  ApiOptions get apiOptions;
  HttpHandler get httpHandler;
  ClientOptions get options;
  Logger get logger;
  Completer<void> get _initializedCompleter;

  /// Create a REST-only client
  static Future<NasbridgeRest> connectRest(String username, String password,
          {RestClientOptions options = const RestClientOptions()}) =>
      connectRestWithOptions(
          RestApiOptions(
              username: username, password: password, host: options.host),
          options);

  /// Create a REST client with custom options
  static Future<NasbridgeRest> connectRestWithOptions(RestApiOptions apiOptions,
      [RestClientOptions clientOptions = const RestClientOptions()]) async {
    clientOptions.logger
      ..info('Connecting to TrueNAS REST API')
      ..fine('Username: ${apiOptions.username}, Host: ${apiOptions.host}')
      ..fine('Plugins: ${clientOptions.plugins.map((p) => p.name).join(', ')}');

    return _doConnect(apiOptions, clientOptions, () async {
      final client = NasbridgeRest._(apiOptions, clientOptions);
      return client;
    }, clientOptions.plugins);
  }

  /// Create a WebSocket-enabled client
  static Future<NasbridgeGateway> connectGateway(
          String username, String password,
          {GatewayClientOptions options = const GatewayClientOptions()}) =>
      connectGatewayWithOptions(
          GatewayApiOptions(
              username: username, password: password, host: options.host),
          options);

  /// Create a WebSocket client with custom options
  static Future<NasbridgeGateway> connectGatewayWithOptions(
    GatewayApiOptions apiOptions, [
    GatewayClientOptions clientOptions = const GatewayClientOptions(),
  ]) async {
    clientOptions.logger
      ..info('Connecting to TrueNAS WebSocket API')
      ..fine('Username: ${apiOptions.username}, Host: ${apiOptions.host}, '
          'Protocol Version: ${apiOptions.protocolVersion}')
      ..fine('Plugins: ${clientOptions.plugins.map((p) => p.name).join(', ')}');

    return _doConnect(apiOptions, clientOptions, () async {
      final client = NasbridgeGateway._(apiOptions, clientOptions);

      return client
        ..gateway = await Gateway.connect(
            client,
            Uri(
              scheme: "ws",
              host: apiOptions.host,
              path: "/websocket",
              port: 80,
            ));
    }, clientOptions.plugins);
  }

  Future<void> close();
}

/// REST-only client implementation
class NasbridgeRest implements Nasbridge {
  @override
  final RestApiOptions apiOptions;

  @override
  final RestClientOptions options;

  @override
  late final HttpHandler httpHandler = HttpHandler(this);

  @override
  Logger get logger => options.logger;

  @override
  final Completer<void> _initializedCompleter = Completer();

  NasbridgeRest._(this.apiOptions, this.options);

  @override
  Future<void> close() {
    logger.info('Closing REST client');
    return _doClose(this, () async => httpHandler.close(), options.plugins);
  }
}

/// WebSocket-enabled client implementation
class NasbridgeGateway with EventMixin implements NasbridgeRest {
  @override
  final GatewayApiOptions apiOptions;

  @override
  final GatewayClientOptions options;

  @override
  late final HttpHandler httpHandler = HttpHandler(this);

  /// The WebSocket gateway connection
  late final Gateway gateway;

  @override
  Logger get logger => options.logger;

  @override
  final Completer<void> _initializedCompleter = Completer();

  NasbridgeGateway._(this.apiOptions, this.options);

  // I don't think this is a very great idea. Ideally we abstract this.
  /// Send a method call to the TrueNAS server
  Future<dynamic> sendMethod(String method, [List<dynamic> params = const []]) {
    return gateway.sendMethod(method, params);
  }

  @override
  Future<void> close() {
    logger.info('Closing WebSocket client');
    return _doClose(this, () async {
      await gateway.close();
      httpHandler.close();
    }, options.plugins);
  }
}
