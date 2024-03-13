import 'package:coop_test/utils/_utils.dart';
import 'package:latlong2/latlong.dart';

class StoreFetchRequest extends GetRequest {
  const StoreFetchRequest._({
    required super.timeout,
    required super.url,
  });

  static StoreFetchRequest forInput(String input) {
    return StoreFetchRequest._(
      timeout: _timeout,
      url: 'https://minside.coop.no/StoreService/SearchStores?searchInput=$input',
    );
  }

  static StoreFetchRequest forLatLng(LatLng latLng) {
    return StoreFetchRequest._(
      timeout: _timeout,
      url:
          'https://minside.coop.no/StoreService/SearchStores?locationLat=${latLng.latitude}&locationLon=${latLng.longitude}',
    );
  }

  static const Duration _timeout = Duration(seconds: 10);
}
