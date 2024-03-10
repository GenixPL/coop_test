import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/screens/_screens.dart';
import 'package:coop_test/utils/_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO(genix): add comments

void main() {
  const Logger logger = Logger();

  final StoreProvider storeProvider = StoreProvider(
    storeProviderFetchHelper: const StoreProviderFetchHelper(),
  );

  const PlaceTaker placeTaker = PlaceTaker(
    logger: logger,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: storeProvider),
      Provider.value(value: placeTaker),
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
