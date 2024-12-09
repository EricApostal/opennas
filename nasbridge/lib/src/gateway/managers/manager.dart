import 'package:nasbridge/src/client.dart';

abstract class Manager<T> {
  final Nasbridge client;

  Manager(this.client);

  // /// Parse the [raw] data received from the Gateway into an instance of the type of this manager.
  // T parse(Map<String, Object?> raw);
}
