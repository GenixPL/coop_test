class StoreFetchRequestData {
  const StoreFetchRequestData._({
    required this.url,
  });

  static StoreFetchRequestData forInput(String input) {
    return StoreFetchRequestData._(
      url: 'https://minside.coop.no/StoreService/SearchStores?searchInput=$input',
    );
  }

  static StoreFetchRequestData forLoc({
    required double lat,
    required double lon,
  }) {
    return StoreFetchRequestData._(
      url: 'https://minside.coop.no/StoreService/SearchStores?locationLat=$lat&locationLon=$lon',
    );
  }

  final String url;
}
