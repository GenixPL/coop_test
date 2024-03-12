import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/screens/_screens.dart';
import 'package:coop_test/utils/_utils.dart';
import 'package:flutter/material.dart';

// TODO(genix): add comments
// TODO(genix): duplication in fetches
// TODO(genix): http client with:
// https://docs.flutter.dev/data-and-backend/networking#platform-notes
// TODO(genix): inits should be moved after initial loading
// TODO(genix): permissions Android and iOS
// TODO(genix): test Android and ios

void main() {
  const Logger logger = Logger();

  const PlaceTaker placeTaker = PlaceTaker(
    logger: logger,
  );

  const GenMapLauncher mapLauncher = GenMapLauncher(
    logger: logger,
  );

  const GenUrlLauncher urlLauncher = GenUrlLauncher(
    logger: logger,
  );

  const GenGeolocator genGeolocator = GenGeolocator(
    logger: logger,
  );

  final LocationProvider locationProvider = LocationProvider(
    logger: logger,
    genGeolocator: genGeolocator,
  );

  const Toaster toaster = Toaster(
    logger: logger,
  );

  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => logger),
      Provider(create: (_) => placeTaker),
      Provider(create: (_) => mapLauncher),
      Provider(create: (_) => urlLauncher),
      Provider(create: (_) => toaster),
      ChangeNotifierProvider.value(value: locationProvider),
    ],
    child: MyApp(
      navKey: placeTaker.navKey,
      toasterKey: toaster.key,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.navKey,
    required this.toasterKey,
  });

  final NavKey navKey;
  final ToasterKey toasterKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navKey,
      scaffoldMessengerKey: toasterKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey.shade800),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
