import 'package:nasbridge/src/client.dart';
import 'package:nasbridge/src/http/route.dart';
import 'package:http/http.dart' hide MultipartRequest;

/// An HTTP request to be made against the API.
///
/// {@template http_request}
/// This class is a wrapper around the [BaseRequest] class from `package:http`, providing rate
/// limit, audit log and authentication support.
/// {@endtemplate}
abstract class HttpRequest {
  /// The name of the header containing the authentication for a request.
  static const authorization = 'Authorization';

  /// The name of the header containing the user agent for a request.
  static const userAgent = 'User-Agent';

  /// The route for this request.
  final HttpRoute route;

  /// The method for this request.
  final String method;

  /// The query parameters for this request.
  final Map<String, String> queryParameters;

  /// The headers for this request.
  final Map<String, String> headers;

  /// Whether to add authentication to this request when sending it.
  final bool authenticated;

  /// The identifier for the rate limit bucket for this request.
  String get rateLimitId => '$method ${route.rateLimitId}';

  /// Create a new [HttpRequest].
  ///
  /// {@macro http_request}
  HttpRequest(
    this.route, {
    this.method = 'GET',
    this.queryParameters = const {},
    this.headers = const {},
    this.authenticated = true,
  });

  /// Transform this [HttpRequest] into a [BaseRequest] to be sent.
  ///
  /// The [client] will be used for authentication if authentication is enabled for this request.
  BaseRequest prepare(Nasbridge client);

  Uri _getUri(Nasbridge client) => Uri.http(
        client.apiOptions.host,
        client.apiOptions.baseUri + route.path,
        queryParameters.isNotEmpty ? queryParameters : null,
      );

  Map<String, String> _getHeaders(Nasbridge client) => {
        // if (authenticated) authorization: client.apiOptions.authorizationHeader,
        "Accept-Language": "en-US",
        "Cache-Control": "no-cache",
        "Pragma": "no-cache",
        "X-Discord-Locale": "en-US",
        "X-Debug-Options": "bugReporterEnabled",
        ...headers,
      };

  @override
  String toString() => 'HttpRequest($method $route)';
}

/// An [HttpRequest] with a JSON body.
class BasicRequest extends HttpRequest {
  /// The `Content-Type` header for JSON requests.
  static const jsonContentTypeHeader = {'Content-Type': 'application/json'};

  /// The JSON-encoded body of this request.
  ///
  /// Set to `null` to send no body.
  final String? body;

  /// Create a new [BasicRequest].
  BasicRequest(
    super.route, {
    this.body,
    super.method,
    super.queryParameters,
    super.authenticated,
    super.headers,
  });

  @override
  Request prepare(Nasbridge client) {
    final request = Request(method, _getUri(client));
    request.headers.addAll(_getHeaders(client));

    if (body != null) {
      request.headers.addAll(jsonContentTypeHeader);
      request.body = body!;
    }

    return request;
  }
}
