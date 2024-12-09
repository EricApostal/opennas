import 'dart:async';
import 'dart:convert';
import 'package:logging/logging.dart';
import 'package:nasbridge/src/gateway/message.dart';
import 'package:nasbridge/src/models/websocket/events/event.dart';
import 'package:nasbridge/src/gateway/event_parser.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GatewayConnection extends Stream<GatewayEvent>
    implements StreamSink<Send> {
  /// The WebSocket connection to TrueNAS
  late WebSocketChannel channel;

  /// Stream of sent messages for tracking
  Stream<Sent> get onSent => _sentController.stream;
  final StreamController<Sent> _sentController = StreamController();

  /// Stream of parsed events from TrueNAS
  final Stream<GatewayEvent> events;

  /// The URI of the TrueNAS WebSocket
  final String gatewayUri;

  /// Maximum number of reconnection attempts
  final int maxReconnectAttempts;

  /// Delay between reconnection attempts (in milliseconds)
  final int reconnectDelay;

  /// Callback to send authentication
  final Function() sendIdentify;

  int _reconnectAttempts = 0;
  Timer? _reconnectTimer;
  bool _isConnected = false;

  GatewayConnection(
    this.channel,
    this.events,
    this.gatewayUri,
    this.sendIdentify, {
    this.maxReconnectAttempts = 5,
    this.reconnectDelay = 5000,
  });

  static Future<GatewayConnection> connect(
      String gatewayUri, Function() sendIdentify) async {
    final logger = Logger('GatewayConnection');
    logger.info("Connecting to $gatewayUri");

    final channel = WebSocketChannel.connect(Uri.parse(gatewayUri));
    await channel.ready;

    final parser = EventParser();
    final eventStream = channel.stream.map((event) {
      final parsed = jsonDecode(event as String) as Map<String, Object?>;
      logger.fine("Received: $parsed");
      return parser.parseGatewayEvent(parsed);
    });

    final connection = GatewayConnection(
      channel,
      eventStream.asBroadcastStream(),
      gatewayUri,
      sendIdentify,
    );

    // Send initial connect message
    await connection.add(Send(method: 'connect', params: [], data: {
      'msg': 'connect',
      'version': '1',
      'support': ['1']
    }));

    channel.sink.done.then((_) {
      connection._handleDisconnect();
    });

    connection._isConnected = true;
    return connection;
  }

  void _handleDisconnect() {
    if (!_isConnected) return;

    logger.info("Connection closed. Attempting to reconnect...");
    if (_reconnectAttempts < maxReconnectAttempts) {
      _reconnectAttempts++;
      _reconnectTimer = Timer(Duration(milliseconds: reconnectDelay), () {
        _attemptReconnect();
      });
    } else {
      logger.severe("Max reconnection attempts reached. Closing connection.");
      close();
    }
  }

  Future<void> _attemptReconnect() async {
    try {
      final newConnection =
          await GatewayConnection.connect(gatewayUri, sendIdentify);
      channel = newConnection.channel;
      _reconnectAttempts = 0;
      logger.info("Reconnection successful.");
      sendIdentify();
    } catch (e) {
      logger.warning("Reconnection failed: $e");
      _handleDisconnect();
    }
  }

  Logger get logger => Logger('GatewayConnection');

  @override
  Future<void> add(Send event) async {
    final payload = event.toJson();
    final encoded = jsonEncode(payload);
    logger.fine("Sending: $encoded");
    channel.sink.add(encoded);
    _sentController.add(Sent(payload: event));
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    channel.sink.addError(error, stackTrace);
  }

  @override
  Future<void> addStream(Stream<Send> stream) => stream.forEach(add);

  @override
  Future<void> close([int code = 1000]) async {
    _isConnected = false;
    logger.info("Closing connection with code $code");
    _reconnectTimer?.cancel();
    await channel.sink.close(code);
    await _sentController.close();
  }

  @override
  Future<void> get done => channel.sink.done.then((_) => _sentController.done);

  @override
  StreamSubscription<GatewayEvent> listen(
    void Function(GatewayEvent event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return events.listen(onData,
        cancelOnError: cancelOnError, onDone: onDone, onError: onError);
  }
}
