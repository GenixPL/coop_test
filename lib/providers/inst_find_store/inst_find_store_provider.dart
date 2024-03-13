import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/utils/_utils.dart';

typedef FindStoreFetchResult = ({
  List<Store>? stores,
  FindStoreFetchError? error,
});

class InstFindStoreProvider extends GenProvider<FindStoreState> {
  InstFindStoreProvider({
    required Logger logger,
    required StoreFetchHelper storeFetchHelper,
  })  : _logger = logger,
        _fetchHelper = storeFetchHelper,
        super(FindStoreState.initial);

  // region Dependencies

  final Logger _logger;
  final StoreFetchHelper _fetchHelper;

  // endregion

  // region Exposed

  Future<FindStoreFetchResult> fetch(StoreFetchRequest storeFetchRequestData) async {
    if (value.isLoading) {
      _logger.error('fetch, different fetch is already in progress!');
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
      _logger.error('fetch, fetch has failed, error: ${result.error}');
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
