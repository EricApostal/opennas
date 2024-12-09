import 'package:nasbridge/src/models/websocket/events/event.dart';

/// Parser for TrueNAS WebSocket events
mixin class EventParser {
  /// Parse a raw WebSocket message into a GatewayEvent
  GatewayEvent parseGatewayEvent(Map<String, Object?> raw) {
    final msg = raw['msg'] as String?;

    switch (msg) {
      case 'connected':
        return ConnectedEvent(
          sessionId: raw['session'] as String,
        );

      case 'failed':
        return FailedEvent(
          message: raw['error'] as String?,
          version: raw['version'] as String?,
        );

      case 'result':
        return ResultEvent(
          id: raw['id'] as String?,
          result: raw['result'],
        );

      case 'error':
        return ErrorEvent(
          id: raw['id'] as String?,
          error: raw['error'] as String?,
          errorMessage: raw['error_message'] as String?,
        );

      case 'sub':
        return SubscriptionEvent(
          collection: raw['collection'] as String,
          id: raw['id'] as String,
          data: raw['fields'] as Map<String, dynamic>,
        );

      case 'pong':
        return PongEvent();

      default:
        return UnknownEvent(raw: RawEvent(data: raw, msg: msg ?? "no message"));
    }
  }
}
