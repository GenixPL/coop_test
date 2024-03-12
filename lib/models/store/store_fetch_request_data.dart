import 'package:latlong2/latlong.dart';

class StoreFetchRequestData {
  const StoreFetchRequestData._({
    required this.url,
  });

  static StoreFetchRequestData forInput(String input) {
    return StoreFetchRequestData._(
      url: 'https://minside.coop.no/StoreService/SearchStores?searchInput=$input',
    );
  }

  static StoreFetchRequestData forLatLng(LatLng latLng) {
    return StoreFetchRequestData._(
      url:
          'https://minside.coop.no/StoreService/SearchStores?locationLat=${latLng.latitude}&locationLon=${latLng.longitude}',
    );
  }

  final String url;
}
