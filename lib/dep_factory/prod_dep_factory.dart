import 'package:coop_test/dep_factory/_dep_factory.dart';
import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/utils/_utils.dart';

class ProdDepFactory extends DepFactory {
  ProdDepFactory();

  // region Utils

  @override
  late final Logger logger = const Logger();

  @override
  late final GenGeolocator genGeolocator = GenGeolocator(
    logger: logger,
  );

  @override
  late final GenMapLauncher mapLauncher = GenMapLauncher(
    logger: logger,
  );

  @override
  late final PlaceTaker placeTaker = PlaceTaker(
    logger: logger,
  );

  @override
  late final Toaster toaster = Toaster(
    logger: logger,
  );

  @override
  late final GenUrlLauncher urlLauncher = GenUrlLauncher(
    logger: logger,
  );

  // endregion

  // region Providers

  @override
  late final LocationProvider locationProvider = LocationProvider(
    logger: logger,
    genGeolocator: genGeolocator,
  );

  // endregion

  // region Instance Providers

  @override
  FindStoreProvider buildFindStoreProvider() {
    return FindStoreProvider();
  }

  // endregion
}
