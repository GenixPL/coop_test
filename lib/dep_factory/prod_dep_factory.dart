import 'package:coop_test/dep_factory/_dep_factory.dart';
import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/utils/_utils.dart';

class ProdDepFactory extends DepFactory {
  ProdDepFactory();

  // region Utils

  @override
  late final GenMapLauncher mapLauncher = GenMapLauncher(
    logger: _buildLogger('GenMapLauncher'),
  );

  @override
  late final PlaceTaker placeTaker = PlaceTaker(
    logger: _buildLogger('PlaceTaker'),
  );

  @override
  late final Toaster toaster = Toaster(
    logger: _buildLogger('Toaster'),
  );

  @override
  late final GenUrlLauncher urlLauncher = GenUrlLauncher(
    logger: _buildLogger('GenUrlLauncher'),
  );

  // endregion

  // region Global Providers

  @override
  late final GlobLocationProvider locationProvider = GlobLocationProvider(
    logger: _buildLogger('GlobLocationProvider'),
    genGeolocator: GenGeolocator(
      logger: _buildLogger('GenGeolocator'),
    ),
  );

  // endregion

  // region Instance Providers

  @override
  InstFindStoreProvider buildFindStoreProvider() {
    return InstFindStoreProvider(
      logger: _buildLogger('InstFindStoreProvider'),
      storeFetchHelper: StoreFetchHelper(
        logger: _buildLogger('StoreFetchHelper'),
        genHttpClient: GenHttpClient(
          clientPool: const SingletonClientPool(),
          logger: _buildLogger('GenHttpClient'),
        ),
      ),
    );
  }

  // endregion

  // region Not Exposed

  Logger _buildLogger(String className) {
    return Logger(
      className: className,
    );
  }

  // endregion
}
