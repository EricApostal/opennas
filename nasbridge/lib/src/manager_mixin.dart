import 'package:nasbridge/src/client.dart';
import 'package:nasbridge/src/gateway/managers/active_directory.dart';
import 'package:nasbridge/src/gateway/managers/system.dart';

/// An internal mixin to add managers to a [Nasbridge] instance.
mixin ManagerMixin implements Nasbridge {
  /// Manager class for handling SystemInfo operations.
  SystemManager get system => SystemManager(this);
  ActiveDirectoryManager get activeDirectory => ActiveDirectoryManager(this);
}
