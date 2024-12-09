import 'package:nasbridge/src/api_options.dart';
import 'package:nasbridge/src/models/websocket/events/event.dart';
import 'package:nasbridge/src/utils/to_string_helper/base_impl.dart';
import 'package:uuid/uuid.dart';

/// The base class for all control messages sent from the gateway to the client.
abstract class GatewayMessage with ToStringHelper {}

/// A gateway message sent when an event is received from TrueNAS.
class EventReceived extends GatewayMessage {
  final GatewayEvent event;
  EventReceived({required this.event});
}

/// A gateway message sent when the gateway encounters an error.
class ErrorReceived extends GatewayMessage {
  final Object error;
  final StackTrace stackTrace;
  ErrorReceived({required this.error, required this.stackTrace});
}

/// A gateway message sent when the gateway is going to disconnect.
class Disconnecting extends GatewayMessage {
  final String reason;
  Disconnecting({required this.reason});
}

/// A gateway message sent when data is being sent to TrueNAS.
class Sent extends GatewayMessage {
  final Send payload;
  Sent({required this.payload});
}

/// Initial connect message sent to establish the WebSocket connection
class Connect extends GatewayMessage {
  Map<String, dynamic> toJson() => {
        'msg': 'connect',
        'version': '1',
        'support': ['1']
      };
}

/// A message to send data to TrueNAS.
class Send extends GatewayMessage {
  static final _uuid = Uuid();

  /// The method to call on the TrueNAS API
  final String method;

  /// The parameters to pass to the method
  final List<dynamic> params;

  /// The unique identifier for this message
  final String? id;

  /// Additional data to include in the message
  final Map<String, Object>? data;

  Send({
    required this.method,
    this.params = const [],
    this.id,
    this.data,
  });

  Map<String, dynamic> toJson() {
    final json = {
      'id': id ?? _uuid.v4(),
      'msg': 'method',
      'method': method,
      'params': params,
    };

    if (data != null) {
      json.addAll(data!);
    }

    return json;
  }
}

/// Configuration for connecting to TrueNAS
class GatewayOptions with ToStringHelper {
  final GatewayApiOptions apiOptions;
  final Uri uri;

  const GatewayOptions({
    required this.apiOptions,
    required this.uri,
  });
}
