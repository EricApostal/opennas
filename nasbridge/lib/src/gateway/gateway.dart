import 'dart:async';
import 'package:logging/logging.dart';
import 'package:nasbridge/src/client.dart';
import 'package:nasbridge/src/errors.dart';
import 'package:nasbridge/src/gateway/connection.dart';
import 'package:nasbridge/src/gateway/message.dart';
import 'package:nasbridge/src/models/gateway/events/event.dart';

class Gateway {
  final NasbridgeGateway client;
  final Uri endpoint;
  final GatewayConnection connection;
  final _logger = Logger('Gateway');
  bool _isAuthenticated = false;
  final _connectionCompleter = Completer<void>();
  final _readyCompleter = Completer<void>();

  /// Stream of all events from the gateway
  late final Stream<GatewayEvent> events = connection.asBroadcastStream();

  /// Future that completes when the gateway is fully connected and authenticated
  Future<void> get ready => _readyCompleter.future;

  Gateway(this.client, this.connection, this.endpoint) {
    connection.listen(
      _handleEvent,
      onError: (error, stack) {
        _logger.severe('Gateway error', error, stack);
        if (!_readyCompleter.isCompleted) {
          _readyCompleter.completeError(error);
        }
      },
      onDone: () => _logger.info('Gateway connection closed'),
    );
  }

  static Future<Gateway> connect(
      NasbridgeGateway client, Uri websocketUri) async {
    final connection = await GatewayConnection.connect(
      websocketUri.toString(),
      () async {
        // this part is actually fucking useless
        // it's for identification for firebridge
        // but it literally just doesn't work

        // will remove later
      },
    );

    final gateway = Gateway(client, connection, websocketUri);
    await gateway._handleInitialConnection();
    return gateway;
  }

  void _handleEvent(GatewayEvent event) {
    _logger.fine('Handling event: ${event.runtimeType}');

    if (event is ConnectedEvent) {
      if (!_connectionCompleter.isCompleted) {
        _connectionCompleter.complete();
      }
    } else if (event is ErrorEvent) {
      _handleError(event);
    }
  }

  // yields until connection is established and authenticated
  // this makes it such that we don't have to require the user to
  // handle auth, and they can assume it's already handled by the
  // time their code runs
  Future<void> _handleInitialConnection() async {
    _logger.info('Initializing connection');
    try {
      // Send initial connect message
      await connection.add(Send(method: 'connect', params: [], data: {
        'msg': 'connect',
        'version': '1',
        'support': ['1']
      }));

      await _connectionCompleter.future;
      _logger.info('Connection established, proceeding with authentication');

      await _authenticate();

      // If we reach here, both connection and authentication are complete
      if (!_readyCompleter.isCompleted) {
        _readyCompleter.complete();
      }
    } catch (e) {
      _logger.severe('Connection/authentication failed', e);
      if (!_readyCompleter.isCompleted) {
        _readyCompleter.completeError(e);
      }
      rethrow;
    }
  }

  Future<void> _authenticate() async {
    if (_isAuthenticated) return;

    _logger.info('Authenticating with TrueNAS');
    try {
      final result = await sendMethod(
        'auth.login',
        [client.apiOptions.username, client.apiOptions.password],
      );

      if (result == true) {
        _isAuthenticated = true;
        _logger.info('Successfully authenticated with TrueNAS');
      } else {
        throw NasbridgeException('Authentication failed: Invalid credentials');
      }
    } catch (e) {
      _logger.severe('Authentication failed', e);
      rethrow;
    }
  }

  void _handleError(ErrorEvent event) {
    final errorMessage = event.errorMessage ?? event.error ?? 'Unknown error';
    _logger.severe('Received error from TrueNAS: $errorMessage');
  }

  /// Send a method call to TrueNAS
  Future<dynamic> sendMethod(String method,
      [List<dynamic> params = const []]) async {
    final completer = Completer<dynamic>();
    final id = _generateId();

    final subscription = events.listen((event) {
      if (event is ResultEvent && event.id == id) {
        completer.complete(event.result);
      } else if (event is ErrorEvent && event.id == id) {
        completer.completeError(NasbridgeException(
            event.errorMessage ?? event.error ?? 'Unknown error'));
      }
    });

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

  /// Send an authenticated method call to TrueNAS
  Future<dynamic> sendAuthenticatedMethod(String method,
      [List<dynamic> params = const []]) async {
    await ready;
    return sendMethod(method, params);
  }

  String _generateId() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> close() async {
    _logger.info('Closing gateway connection');
    await connection.close();
  }
}
