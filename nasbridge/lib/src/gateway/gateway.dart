import 'dart:async';
import 'package:logging/logging.dart';
import 'package:nasbridge/src/client.dart';
import 'package:nasbridge/src/errors.dart';
import 'package:nasbridge/src/gateway/connection.dart';
import 'package:nasbridge/src/gateway/message.dart';
import 'package:nasbridge/src/models/websocket/events/event.dart';

/// Main gateway class for handling TrueNAS WebSocket connections
class Gateway {
  final NasbridgeGateway client;
  final Uri endpoint;
  final GatewayConnection connection;
  final _logger = Logger('Gateway');
  bool _isAuthenticated = false;

  /// Stream of all events from the gateway
  late final Stream<GatewayEvent> events = connection.asBroadcastStream();

  Gateway(this.client, this.connection, this.endpoint) {
    connection.listen(
      _handleEvent,
      onError: (error, stack) => _logger.severe('Gateway error', error, stack),
      onDone: () => _logger.info('Gateway connection closed'),
    );
  }

  static Future<Gateway> connect(
      NasbridgeGateway client, Uri websocketUri) async {
    final connection = await GatewayConnection.connect(
      websocketUri.toString(),
      () async {
        // Initial connection handler
        await client.gateway._authenticate();
      },
    );

    return Gateway(client, connection, websocketUri);
  }

  void _handleEvent(GatewayEvent event) {
    if (event is ConnectedEvent) {
      _handleInitialConnection();
    } else if (event is ResultEvent) {
      _handleResponse(event);
    } else if (event is ErrorEvent) {
      _handleError(event);
    }
  }

  Future<void> _handleInitialConnection() async {
    // Send initial connect message
    await connection.add(Send(method: 'connect', params: [], data: {
      'msg': 'connect',
      'version': '1',
      'support': ['1']
    }));

    // Proceed with authentication
    await _authenticate();
  }

  Future<void> _authenticate() async {
    if (_isAuthenticated) return;

    _logger.info('Authenticating with TrueNAS');
    await connection.add(Send(
      method: 'auth.login',
      params: [client.apiOptions.username, client.apiOptions.password],
    ));
  }

  void _handleResponse(ResultEvent event) {
    if (!_isAuthenticated) {
      // Handle authentication response
      if (event.result == true) {
        _isAuthenticated = true;
        _logger.info('Successfully authenticated with TrueNAS');
      } else {
        _logger.severe('Authentication failed');
        throw NasbridgeException('Failed to authenticate with TrueNAS');
      }
    }
  }

  void _handleError(ErrorEvent event) {
    final errorMessage = event.errorMessage ?? event.error ?? 'Unknown error';
    _logger.severe('Received error from TrueNAS: $errorMessage');

    if (!_isAuthenticated) {
      throw NasbridgeException('Authentication failed: $errorMessage');
    }
  }

  /// Send a method call to TrueNAS
  Future<dynamic> sendMethod(String method,
      [List<dynamic> params = const []]) async {
    // if (!_isAuthenticated) {
    //   throw NasbridgeException('Must be authenticated to send methods');
    // }

    final completer = Completer<dynamic>();
    final id = _generateId();

    // Set up listener for the response
    final subscription = events.listen((event) {
      if (event is ResultEvent && event.id == id) {
        completer.complete(event.result);
      } else if (event is ErrorEvent && event.id == id) {
        completer.completeError(NasbridgeException(
            event.errorMessage ?? event.error ?? 'Unknown error'));
      }
    });

    // Send the request
    await connection.add(Send(
      method: method,
      params: params,
      id: id,
    ));

    try {
      return await completer.future;
    } finally {
      await subscription.cancel();
    }
  }

  String _generateId() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> close() async {
    _logger.info('Closing gateway connection');
    await connection.close();
  }
}
