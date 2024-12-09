import 'package:nasbridge/src/client.dart';
import 'package:nasbridge/src/gateway/gateway.dart';

abstract class MethodManager {
  final Nasbridge client;

  MethodManager(this.client);
}
