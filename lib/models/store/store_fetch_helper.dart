import 'dart:async';

import 'package:coop_test/models/_models.dart';
import 'package:coop_test/utils/_utils.dart';
import 'package:http/http.dart' as http;

typedef StoreFetchResult = ({
  List<Store>? stores,
  HttpError? error,
});

class StoreFetchHelper {
  const StoreFetchHelper({
    required Logger logger,
  }) : _logger = logger;

  // region Dependencies

  final Logger _logger;

  // endregion

  // region Values

  static const Duration _fetchTimeout = Duration(seconds: 10);

  // endregion

  // region Exposed

  Future<StoreFetchResult> fetch(StoreFetchRequestData requestData) async {
    final String body;
    try {
      final http.Response response = await http.Client().get(Uri.parse(requestData.url)).timeout(_fetchTimeout);

      if (response.statusCode != 200) {
        return (
          stores: null,
          error: HttpCodeError(
            statusCode: response.statusCode,
          ),
        );
      }

      body = response.body;
    } catch (e) {
      _logger.error('fetchForInput, fetch error: $e');

      if (e is TimeoutException) {
        return (
          stores: null,
          error: const HttpTimeoutError(),
        );
      }

      return (
        stores: null,
        error: const HttpUnknownError(),
      );
    }

    final List<dynamic>? storesJsonList = body.toJsonMap()?.getValue('Stores');
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

      stores.add(rawStore.toStore());
    }

    return (
      stores: stores,
      error: null,
    );
  }

  // endregion
}
