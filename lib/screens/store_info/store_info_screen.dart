import 'package:coop_test/models/_models.dart';
import 'package:coop_test/widgets/_widgets.dart';
import 'package:flutter/material.dart';

class StoreInfoScreen extends StatelessWidget {
  const StoreInfoScreen({
    super.key,
    required this.store,
  });

  static const String routeName = 'StoreInfoScreen';

  static MaterialPageRoute<Widget> route({
    required Store store,
  }) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) {
        return StoreInfoScreen(
          store: store,
        );
      },
    );
  }

  final Store store;

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: AppBar(
        title: const Text('store info'),
      ),
      layout: ScrollableLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(store.id),
            Text(store.name),
            Text(store.lat.toString()),
            Text(store.lon.toString()),
            Text(store.newsletterUrl),
            // TODO(genix): map goes here
          ],
        ),
      ),
    );
  }
}
