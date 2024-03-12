import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/screens/_screens.dart';
import 'package:coop_test/utils/_utils.dart';
import 'package:flutter/material.dart';

// TODO(genix): add comments
// TODO(genix): duplication in fetches
// TODO(genix): http client with:
// https://docs.flutter.dev/data-and-backend/networking#platform-notes
// TODO(genix): inits should be moved after initial loading

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

  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => logger),
      Provider(create: (_) => placeTaker),
      Provider(create: (_) => mapLauncher),
      Provider(create: (_) => urlLauncher),
    ],
    child: MyApp(
      navKey: placeTaker.navKey,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.navKey,
  });

  final NavKey navKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
