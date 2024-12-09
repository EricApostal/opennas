import 'package:nasbridge/src/utils/to_string_helper/base_impl.dart';

/// {@template gateway_event}
/// The base class for all events received from the TrueNAS WebSocket.
/// {@endtemplate}
abstract class GatewayEvent with ToStringHelper {}

/// {@template raw_event}
/// Raw WebSocket message from TrueNAS before parsing.
/// {@endtemplate}
class RawEvent extends GatewayEvent {
  /// The message type
  final String msg;

  /// The message ID if present
  final String? id;

  /// The raw message data
  final Map<String, dynamic> data;

  /// {@macro raw_event}
  RawEvent({
    required this.msg,
    this.id,
    required this.data,
  });
}

/// {@template connected_event}
/// Emitted when the initial connection is established.
/// {@endtemplate}
class ConnectedEvent extends GatewayEvent {
  /// The protocol version that was accepted
  final String sessionId;

  /// {@macro connected_event}
  ConnectedEvent({required this.sessionId});
}

/// {@template method_result_event}
/// Emitted when a method call returns a result.
/// {@endtemplate}
class MethodResultEvent extends GatewayEvent {
  /// The ID of the method call
  final String id;

  /// The method that was called
  final String method;

  /// The result data
  final dynamic result;

  /// {@macro method_result_event}
  MethodResultEvent({
    required this.id,
    required this.method,
    required this.result,
  });
}

/// {@template method_error_event}
/// Emitted when a method call results in an error.
/// {@endtemplate}
class MethodErrorEvent extends GatewayEvent {
  /// The ID of the method call
  final String id;

  /// The error code
  final String error;

  /// The error message
  final String? message;

  /// {@macro method_error_event}
  MethodErrorEvent({
    required this.id,
    required this.error,
    this.message,
  });
}

/// {@template subscription_event}
/// Emitted when subscription data is received.
/// {@endtemplate}
class SubscriptionEvent extends GatewayEvent {
  /// The subscription ID
  final String id;

  /// The collection being subscribed to
  final String collection;

  /// The updated data
  final Map<String, dynamic> data;

  /// {@macro subscription_event}
  SubscriptionEvent({
    required this.id,
    required this.collection,
    required this.data,
  });
}

/// {@template failed_event}
/// Emitted when the connection encounters an error.
/// {@endtemplate}
class FailedEvent extends GatewayEvent {
  /// The error message
  final String? message;

  /// The error version if applicable
  final String? version;

  /// {@macro failed_event}
  FailedEvent({
    this.message,
    this.version,
  });
}

/// {@template unknown_event}
/// Emitted when an unknown message type is received.
/// {@endtemplate}
class UnknownEvent extends GatewayEvent {
  /// The raw event that couldn't be parsed
  final RawEvent raw;

  /// {@macro unknown_event}
  UnknownEvent({
    required this.raw,
  });
}

/// Event received when authentication succeeds
class AuthSuccessEvent extends GatewayEvent {
  AuthSuccessEvent();
}

/// Event received when authentication fails
class AuthFailedEvent extends GatewayEvent {
  final String? error;

  AuthFailedEvent({this.error});
}

/// Event received when a method call succeeds
class ResultEvent extends GatewayEvent {
  final String? id;
  final dynamic result;

  ResultEvent({this.id, this.result});
}

/// Event received when a method call fails
class ErrorEvent extends GatewayEvent {
  final String? id;
  final String? error;
  final String? errorMessage;

  ErrorEvent({this.id, this.error, this.errorMessage});
}

/// Event received in response to ping messages
class PongEvent extends GatewayEvent {}

/// Event for system information updates
class SystemInfoEvent extends GatewayEvent {
  final Map<String, dynamic> info;

  SystemInfoEvent({required this.info});
}
