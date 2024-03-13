import 'package:coop_test/dep_factory/_dep_factory.dart';
import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/screens/_screens.dart';
import 'package:coop_test/utils/_utils.dart';
import 'package:coop_test/widgets/_widgets.dart';
import 'package:flutter/material.dart';

class FindStoreScreen extends StatelessWidget {
  const FindStoreScreen({
    super.key,
  });

  static const String routeName = 'FindStoreScreen';

  static Route<Widget> route() {
    return RouteBuilder.defaultRoute(
      routeName: routeName,
      screen: const FindStoreScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: AppBar(
        title: const Text('find store'),
      ),
      child: ChangeNotifierProvider(
        create: (_) => context.read<DepFactory>().buildFindStoreProvider(),
        child: Consumer<InstFindStoreProvider>(
          builder: (BuildContext context, InstFindStoreProvider provider, Widget? child) {
            return FindStoreBody(
              state: provider.value,
              onFindStores: context.read<InstFindStoreProvider>().fetch,
            );
          },
        ),
      ),
    );
  }
}
