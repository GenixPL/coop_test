import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/utils/_utils.dart';

typedef FindStoreFetchResult = ({
  List<Store>? stores,
  FindStoreFetchError? error,
});

// TODO(genix): rename to inst and glob
class FindStoreProvider extends GenProvider<FindStoreState> {
  FindStoreProvider() : super(FindStoreState.initial);

  // region Dependencies

  final StoreFetchHelper _fetchHelper = const StoreFetchHelper(
    logger: Logger(),
  );

  // endregion

  // region Exposed

  Future<FindStoreFetchResult> fetch(StoreFetchRequestData storeFetchRequestData) async {
    if (value.isLoading) {
      return (
        stores: null,
        error: const FindStoreFetchInProgressError(),
      );
    }

    value = value.copyWith(isLoading: true);

    // Get
    final StoreFetchResult result = await _fetchHelper.fetch(storeFetchRequestData);

    // Handle error
    final List<Store>? stores = result.stores;
    if (stores == null) {
      value = value.copyWith(isLoading: false);
      return (
        stores: null,
        error: FindStoreFetchFailedFetchError(
          httpError: result.error,
        ),
      );
    }

    // Handle good
    value = value.copyWith(
      isLoading: false,
      stores: stores,
    );

    return (
      stores: stores,
      error: null,
    );
  }

  // endregion
}
