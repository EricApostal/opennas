import 'dart:async';

import 'package:nasbridge/src/client.dart';
import 'package:nasbridge/src/http/response.dart';
import 'package:http/http.dart' hide MultipartRequest;
import 'package:nasbridge/src/http/request.dart';
import 'package:logging/logging.dart';

extension on HttpRequest {
  String get loggingId => '$method $route';
}

/// A handler for making HTTP requests to the Discord API.
///
/// {@template http_handler}
/// HTTP requests can be made using the [execute] method.
/// {@endtemplate}
class HttpHandler {
  /// The client this handler is attached to.
  final Nasbridge client;

  /// The HTTP client used to make requests.
  final Client httpClient = Client();

  Logger get logger => Logger('${client.options.loggerName}.Http');

  final StreamController<HttpRequest> _onRequestController =
      StreamController.broadcast();
  final StreamController<HttpResponse> _onResponseController =
      StreamController.broadcast();

  /// A stream of requests executed by this handler.
  ///
  /// Requests are emitted before they are sent.
  Stream<HttpRequest> get onRequest => _onRequestController.stream;

  /// A stream of responses received by this handler.
  Stream<HttpResponse> get onResponse => _onResponseController.stream;

  /// Create a new [HttpHandler].
  ///
  /// {@macro http_handler}
  HttpHandler(this.client);

  /// Send [request] to the API and return the response.
  ///
  /// If the response has a status code of 2XX, a [HttpResponseSuccess] is returned.
  /// Otherwise, this method returns a [HttpResponseError].
  ///
  /// This method calls [ChloroplastPlugin.interceptRequest] on all plugins registered to the [client] which may intercept the [request].
  Future<HttpResponse> execute(HttpRequest request) async {
    final executeFn = client.options.plugins.fold(
      _execute,
      (previousValue, plugin) => (request) {
        return plugin.interceptRequest(client, request, previousValue);
      },
    );
    return await executeFn(request);
  }

  Future<HttpResponse> _execute(HttpRequest request) async {
    logger
      ..fine(request.loggingId)
      ..finer(
        'Headers: ${request.headers}'
        'Authenticated: ${request.authenticated}',
      );

    if (request is BasicRequest) {
      logger.finer(
          'Query Parameters: ${request.queryParameters}, Body: ${request.body}');
    } else {
      logger.finer('Query parameters: ${request.queryParameters}');
    }

    _onRequestController.add(request);

    try {
      logger.finer('Sending ${request.loggingId}');
      final response = await httpClient.send(request.prepare(client));
      return _handle(request, response);
    } catch (e) {
      logger.severe('Error executing request ${request.loggingId}: $e');
      rethrow;
    }
  }

  /// Execute [request] and throw the response if it is not a [HttpResponseSuccess].
  Future<HttpResponseSuccess> executeSafe(HttpRequest request) async {
    final response = await execute(request);

    if (response is! HttpResponseSuccess) {
      throw response;
    }

    return response;
  }

  Future<HttpResponse> _handle(
      HttpRequest request, StreamedResponse response) async {
    final HttpResponse parsedResponse;
    if (response.statusCode >= 200 && response.statusCode < 300) {
      parsedResponse =
          await HttpResponseSuccess.fromResponse(request, response);
    } else {
      parsedResponse = await HttpResponseError.fromResponse(request, response);
    }

    logger
      ..fine('${response.statusCode} ${request.loggingId}')
      ..finer(
          'Headers: ${parsedResponse.headers}, Body: ${parsedResponse.textBody ?? parsedResponse.body.map((e) => e.toRadixString(16)).join(' ')}');

    _onResponseController.add(parsedResponse);
    return parsedResponse;
  }

  void close() {
    httpClient.close();
    _onRequestController.close();
    _onResponseController.close();
  }
}
