import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/utils/_utils.dart';

class StoreProvider extends GenProvider {
  StoreProvider({
    required StoreProviderFetchHelper storeProviderFetchHelper,
  }) : _fetchHelper = storeProviderFetchHelper;

  // region Dependencies

  final StoreProviderFetchHelper _fetchHelper;

  // endregion

  // region Values

  final List<Store> _stores = <Store>[];
  late StoreProviderState _state = StoreProviderLoadingState(
    stores: _stores,
  );

  // endregion

  // region Exposed

  @override
  void init() {
    // Load from storage

    _state = StoreProviderLoadedState(
      stores: _stores,
    );
    notifyListeners();
  }

  StoreProviderState get state {
    return _state;
  }

  Future<HttpError?> fetchForInput(String input) async {
    return _handleFetch(
      fetchFunction: () => _fetchHelper.fetchForInput(input),
    );
  }

  Future<HttpError?> fetchForLoc({
    required double lat,
    required double lon,
  }) async {
    return _handleFetch(
      fetchFunction: () => _fetchHelper.fetchForLoc(
        lat: lat,
        lon: lon,
      ),
    );
  }

  // endregion

  // region Not Exposed

  Future<HttpError?> _handleFetch({
    required Future<StoreFetchResult> Function() fetchFunction,
  }) async {
    _state = StoreProviderLoadingState(
      stores: _stores,
    );
    notifyListeners();

    // Get
    final StoreFetchResult result = await fetchFunction.call();

    // Handle error
    final List<Store>? newStores = result.stores;
    if (newStores == null) {
      _state = StoreProviderLoadedState(
        stores: _stores,
      );
      notifyListeners();
      return result.error ?? const HttpUnknownError();
    }

    // Handle good
    for (Store store in newStores) {
      if (!_stores.contains(store)) {
        _stores.add(store);
      }
    }

    _state = StoreProviderLoadedState(
      stores: _stores,
    );
    notifyListeners();

    return null;
  }

  // endregion
}
