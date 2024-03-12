import 'package:coop_test/models/_models.dart';
import 'package:coop_test/screens/_screens.dart';
import 'package:coop_test/utils/_utils.dart';

class FindStoreProvider extends GenProvider<FindStoreState> {
  FindStoreProvider()
      : super(const FindStoreState(
          isLoading: false,
          stores: <Store>[],
          view: FindStoreScreenView.list,
        ));

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

  void changeView(FindStoreScreenView view) {
    value = value.copyWith(
      view: view,
    );
  }

  // endregion
}
