import 'dart:async';
import 'package:logging/logging.dart';
import 'package:nasbridge/src/api_options.dart';
import 'package:nasbridge/src/client.dart';
import 'package:nasbridge/src/client_options.dart';
import 'package:nasbridge/src/plugin/plugin.dart';

/// A global instance of the [Logging] plugin.
final logging = Logging();

/// A plugin that outputs a client's logs to [stdout] and [stderr].
class Logging extends NasbridgePlugin {
  @override
  String get name => 'Logging';

  /// The level above which logs are outputted to [stderr] instead of [stdout].
  final Level stderrLevel;

  /// The level at which stack traces are automatically recorded.
  final Level stackTraceLevel;

  /// The level above which logs are outputted.
  final Level logLevel;

  /// The number of characters after which log messages are truncated.
  final int? truncateLogsAt;

  /// Whether to censor credentials of clients this plugin is attached to.
  final bool censorCredentials;

  /// Create a new instance of the [Logging] plugin.
  Logging({
    this.stderrLevel = Level.WARNING,
    this.stackTraceLevel = Level.SEVERE,
    this.logLevel = Level.INFO,
    this.truncateLogsAt = 1000,
    this.censorCredentials = true,
  }) {
    _listenIfNeeded();
  }

  static int _clients = 0;
  final List<_Credentials> _credentials = [];
  Level? _oldStacktraceLevel;
  Level? _oldLogLevel;
  StreamSubscription<void>? _subscription;

  void _listenIfNeeded() {
    if (_subscription != null) return;

    _oldStacktraceLevel = recordStackTraceAtLevel;
    _oldLogLevel = Logger.root.level;
    recordStackTraceAtLevel = stackTraceLevel;
    Logger.root.level = logLevel;

    _subscription = Logger.root.onRecord.listen((LogRecord rec) {
      final message = StringBuffer();
      var customMessage = rec.message;

      if (truncateLogsAt != null && customMessage.length > truncateLogsAt!) {
        customMessage = '${customMessage.substring(0, truncateLogsAt! - 3)}...';
      }

      message.writeln(
          '[${rec.time}] [${rec.level.name}] [${rec.loggerName}] $customMessage');

      final error = rec.error;
      if (error != null) {
        message.write('Error: ');
        final errorMessage = error.toString();
        if (errorMessage.contains('\n')) {
          message.writeln();
          message.writeln(errorMessage);
          message.writeln();
        } else {
          message.writeln(errorMessage);
        }
      }

      final stackTrace =
          (error is Error ? error.stackTrace : null) ?? rec.stackTrace;
      if (stackTrace != null) {
        message.writeln('Stack trace:\n$stackTrace\n');
      }

      var messageString = message.toString();
      if (censorCredentials) {
        for (final cred in _credentials) {
          messageString = messageString
              .replaceAll(cred.username, '<username>')
              .replaceAll(cred.password, '<password>');
        }
      }

      // very advanced
      print(messageString);
    });
  }

  void _stopListeningIfNeeded() {
    if (_clients > 0) return;

    recordStackTraceAtLevel = _oldStacktraceLevel!;
    Logger.root.level = _oldLogLevel!;
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  void beforeConnect(ApiOptions apiOptions, ClientOptions clientOptions) {
    if (apiOptions is RestApiOptions) {
      _credentials.add(_Credentials(
        username: apiOptions.username,
        password: apiOptions.password,
      ));
    }
    _clients++;
  }

  @override
  Future<void> doClose(Nasbridge client, Future<void> Function() close) async {
    await super.doClose(client, close);
    _clients--;
    _stopListeningIfNeeded();

    if (client is NasbridgeRest) {
      _credentials.removeWhere((cred) =>
          cred.username == client.apiOptions.username &&
          cred.password == client.apiOptions.password);
    }
  }
}

/// Internal class to store credentials for censoring
class _Credentials {
  final String username;
  final String password;

  _Credentials({required this.username, required this.password});
}
