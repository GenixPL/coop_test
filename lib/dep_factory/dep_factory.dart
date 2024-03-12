import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/utils/_utils.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter/foundation.dart';

export 'package:provider/single_child_widget.dart';

abstract class DepFactory {
  const DepFactory();

  List<SingleChildWidget> get allGlobalProviders {
    return [
      Provider.value(value: this),
      ...utilsAsProvider,
      ...globalProvidersAsProviders,
    ];
  }

  // region Utils

  @nonVirtual
  @protected
  List<SingleChildWidget> get utilsAsProvider {
    return [
      Provider(create: (_) => logger),
      Provider(create: (_) => genGeolocator),
      Provider(create: (_) => placeTaker),
      Provider(create: (_) => mapLauncher),
      Provider(create: (_) => urlLauncher),
      Provider(create: (_) => toaster),
    ];
  }

  @protected
  Logger get logger;

  @protected
  GenGeolocator get genGeolocator;

  @protected
  PlaceTaker get placeTaker;

  @protected
  GenMapLauncher get mapLauncher;

  @protected
  GenUrlLauncher get urlLauncher;

  @protected
  Toaster get toaster;

  // endregion

  // region Global Providers

  @nonVirtual
  @protected
  List<SingleChildWidget> get globalProvidersAsProviders {
    return [
      ChangeNotifierProvider(create: (_) => locationProvider),
    ];
  }

  LocationProvider get locationProvider;

  // endregion

  // region Instance Providers

  FindStoreProvider buildFindStoreProvider();

  // endregion
}
