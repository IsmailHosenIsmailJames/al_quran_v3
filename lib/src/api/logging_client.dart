import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

/// A custom HTTP client that logs all requests and responses.
class LoggingClient extends http.BaseClient {
  static final LoggingClient _instance = LoggingClient._internal();
  factory LoggingClient() => _instance;
  LoggingClient._internal();

  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final startTime = DateTime.now();
    // Unique-ish ID for matching request/response in logs
    final requestId = startTime.millisecondsSinceEpoch.toString().substring(7);

    // 1. Log Request Details
    _logRequest(request, requestId);

    try {
      // 2. Execute Request
      final response = await _inner.send(request);
      
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // 3. Read body to log it (and re-wrap it for the caller)
      final bytes = await response.stream.toBytes();
      
      // 4. Log Response Details
      _logResponse(response, bytes, requestId, duration);
      
      return http.StreamedResponse(
        Stream.value(bytes),
        response.statusCode,
        contentLength: bytes.length,
        request: request,
        headers: response.headers,
        isRedirect: response.isRedirect,
        persistentConnection: response.persistentConnection,
        reasonPhrase: response.reasonPhrase,
      );
    } catch (e, stackTrace) {
      developer.log(
        '[$requestId] ❌ Request failed: $e',
        name: 'API_LOG',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  void _logRequest(http.BaseRequest request, String id) {
    String bodyInfo = '';
    if (request is http.Request && request.body.isNotEmpty) {
      try {
        final dynamic json = jsonDecode(request.body);
        bodyInfo = '\nBody: ${const JsonEncoder.withIndent('  ').convert(json)}';
      } catch (_) {
        bodyInfo = '\nBody: ${request.body}';
      }
    }

    developer.log(
      '[$id] 🚀 ${request.method} ${request.url}\nHeaders: ${request.headers}$bodyInfo',
      name: 'API_LOG',
    );
  }

  void _logResponse(
    http.StreamedResponse response, 
    List<int> bytes, 
    String id, 
    Duration duration
  ) {
    String bodyString = utf8.decode(bytes);
    if (bodyString.isNotEmpty) {
      try {
        final dynamic json = jsonDecode(bodyString);
        bodyString = const JsonEncoder.withIndent('  ').convert(json);
      } catch (_) {
        // Not JSON or too large to decode safely, keep original
      }
    }

    final statusIcon = response.statusCode >= 200 && response.statusCode < 300 ? '✅' : '⚠️';

    developer.log(
      '[$id] $statusIcon ${response.statusCode} (${duration.inMilliseconds}ms)\nHeaders: ${response.headers}\nBody: ${bodyString.isEmpty ? '(Empty Body)' : bodyString}',
      name: 'API_LOG',
    );
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}
