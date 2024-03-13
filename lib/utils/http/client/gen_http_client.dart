import 'dart:async';

import 'package:coop_test/utils/_utils.dart';

typedef HttpResult = ({
  Response? response,
  HttpError? error,
});

// Setup: https://docs.flutter.dev/data-and-backend/networking#platform-notes
class GenHttpClient {
  const GenHttpClient({
    required ClientPool clientPool,
    required Logger logger,
  })  : _clientPool = clientPool,
        _logger = logger;

  // region Dependencies

  final ClientPool _clientPool;
  final Logger _logger;

  // endregion

  Future<HttpResult> send(HttpRequest request) async {
    final Uri? uri = Uri.tryParse(request.url);
    if (uri == null) {
      _logger.error('send, could not parse url (${request.url})!');
      return (
        response: null,
        error: HttpWrongUrlError(
          url: request.url,
        ),
      );
    }

    final Client client = _clientPool.getClient();

    try {
      final Future<Response> futureResponse;
      switch (request) {
        case GetRequest():
          futureResponse = client.get(uri);
          break;
      }

      return (
        response: await futureResponse.timeout(request.timeout),
        error: null,
      );
    } on TimeoutException {
      _logger.error('send, timeout!');
      return (
        response: null,
        error: const HttpTimeoutError(),
      );
    } catch (e) {
      _logger.error('send, unrecognised error: $e');
      return (
        response: null,
        error: const HttpUnknownError(),
      );
    } finally {
      _clientPool.doneUsing(client);
    }
  }
}
