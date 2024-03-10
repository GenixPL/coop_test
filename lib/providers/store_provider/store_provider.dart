import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/utils/_utils.dart';

class StoreProvider extends CoopProvider {
  StoreProvider({
    required StoreProviderFetchHelper storeProviderFetchHelper,
  }) : _fetchHelper = storeProviderFetchHelper;

  // region Dependencies

  final StoreProviderFetchHelper _fetchHelper;

  // endregion

  // region Values

  final List<String> _storeInfo = <String>[];
  StoreProviderState _state = const StoreProviderLoadingState();

  // endregion

  // region Exposed

  @override
  void init() {
    // Load from storage
  }

  StoreProviderState get state {
    return _state;
  }

  Future<HttpError?> fetchFromInput(String input) async {
    return HttpNoInternetError();
  }

  Future<HttpError?> fetchFromLoc({
    required double lat,
    required double lon,
  }) async {
    return HttpNoInternetError();
  }

  // endregion
}
