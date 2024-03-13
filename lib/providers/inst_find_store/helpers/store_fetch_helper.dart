import 'dart:async';

import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/utils/_utils.dart';

typedef StoreFetchResult = ({
  List<Store>? stores,
  HttpError? error,
});

class StoreFetchHelper {
  const StoreFetchHelper({
    required Logger logger,
    required GenHttpClient genHttpClient,
  })  : _logger = logger,
        _httpClient = genHttpClient;

  // region Dependencies

  final Logger _logger;
  final GenHttpClient _httpClient;

  // endregion

  // region Exposed

  Future<StoreFetchResult> fetch(StoreFetchRequest request) async {
    final HttpResult result = await _httpClient.send(request);

    final Response? response = result.response;
    if (response == null) {
      return (
        stores: null,
        error: result.error,
      );
    }

    if (response.statusCode != 200) {
      return (
        stores: null,
        error: HttpCodeError(
          statusCode: response.statusCode,
        ),
      );
    }

    final List<dynamic>? storesJsonList = response.body.toJsonMap()?.getValue('Stores');
    if (storesJsonList == null) {
      return (
        stores: null,
        error: const HttpParseError(),
      );
    }

    final List<Store> stores = <Store>[];
    for (dynamic storeJson in storesJsonList) {
      final RawStore rawStore;
      try {
        rawStore = RawStore.fromJson(storeJson);
      } catch (e, stc) {
        _logger.error('fetchForInput, parse error: $e\nstc: $stc');
        return (
          stores: null,
          error: const HttpParseError(),
        );
      }

      stores.add(rawStore);
    }

    return (
      stores: stores,
      error: null,
    );
  }

  // endregion
}
