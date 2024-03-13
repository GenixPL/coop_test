import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/utils/_utils.dart';

class FindStoreProvider extends GenProvider<FindStoreState> {
  FindStoreProvider() : super(FindStoreState.initial);

  // region Dependencies

  final StoreFetchHelper _fetchHelper = const StoreFetchHelper(
    logger: Logger(),
  );

  // endregion

  // region Exposed

  Future<List<Store>?> fetch(StoreFetchRequestData storeFetchRequestData) async {
    if (value.isLoading) {
      print('ALREADY FETCHING');
      return null;
    }

    value = value.copyWith(isLoading: true);

    // Get
    final StoreFetchResult result = await _fetchHelper.fetch(storeFetchRequestData);

    // Handle error
    final List<Store>? stores = result.stores;
    if (stores == null) {
      value = value.copyWith(isLoading: false);
      // Logger
      print(result.error);
      return null;
    }

    // Handle good
    value = value.copyWith(
      isLoading: false,
      stores: stores,
    );

    return stores;
  }

  // endregion
}
