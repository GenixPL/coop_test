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
      url: '$_commonPart?searchInput=$input',
    );
  }

  static StoreFetchRequest forLatLng(LatLng latLng) {
    return StoreFetchRequest._(
      timeout: _timeout,
      url: '$_commonPart?locationLat=${latLng.latitude}&locationLon=${latLng.longitude}',
    );
  }

  static const String _commonPart = 'https://minside.coop.no/StoreService/SearchStores';
  static const Duration _timeout = Duration(seconds: 10);
}
