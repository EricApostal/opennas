import 'dart:async';
import 'package:nasbridge/src/client.dart';
import 'package:nasbridge/src/models/websocket/events/event.dart';
import 'package:nasbridge/src/utils/iterable_extension.dart';

/// An internal mixin to add event streams to a TrueNAS client.
mixin EventMixin implements Nasbridge {
  /// A [Stream] of gateway events received by this client.
  Stream<GatewayEvent> get onEvent => (this as NasbridgeGateway).gateway.events;

  /// A [Stream] of unknown events.
  Stream<UnknownEvent> get onUnknownEvent => onEvent.whereType<UnknownEvent>();

  /// Helper function to listen to events of a specific type.
  ///
  /// Example:
  /// ```dart
  /// client.on<AuthSuccessEvent>((event) => print('Successfully authenticated'));
  /// ```
  StreamSubscription<T> on<T extends GatewayEvent>(
          void Function(T event) onData) =>
      onEvent.whereType<T>().listen(onData);

  /// A [Stream] of successful authentication events.
  Stream<AuthSuccessEvent> get onAuthSuccess =>
      onEvent.whereType<AuthSuccessEvent>();

  /// A [Stream] of authentication failure events.
  Stream<AuthFailedEvent> get onAuthFailed =>
      onEvent.whereType<AuthFailedEvent>();

  /// A [Stream] of initial connection events.
  Stream<ConnectedEvent> get onConnected => onEvent.whereType<ConnectedEvent>();

  /// A [Stream] of method result events.
  Stream<MethodResultEvent> get onMethodResult =>
      onEvent.whereType<MethodResultEvent>();

  /// A [Stream] of system info events.
  Stream<SystemInfoEvent> get onSystemInfo => onMethodResult
      .where((event) => event.method == 'system.info')
      .map((event) => SystemInfoEvent(info: event.result));
}
