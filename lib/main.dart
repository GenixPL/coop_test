import 'package:coop_test/dep_factory/_dep_factory.dart';
import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/screens/_screens.dart';
import 'package:coop_test/utils/_utils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DepInjector(
    depFactory: ProdDepFactory(),
    child: const MyApp(),
  ));
}

class DepInjector extends StatelessWidget {
  const DepInjector({
    super.key,
    required this.depFactory,
    required this.child,
  });

  final DepFactory depFactory;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: depFactory.allGlobalProviders,
      child: child,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: context.read<PlaceTaker>().navKey,
      scaffoldMessengerKey: context.read<Toaster>().key,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey.shade800),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
