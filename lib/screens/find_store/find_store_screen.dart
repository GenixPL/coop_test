import 'package:coop_test/widgets/_widgets.dart';
import 'package:flutter/material.dart';

class FindStoreScreen extends StatelessWidget {
  const FindStoreScreen({super.key});

  static const String routeName = 'FindStoreScreen';

  static MaterialPageRoute<Widget> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) {
        return const FindStoreScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: AppBar(
        title: const Text('find store'),
      ),
      layout: ExpandedLayout(
        child: Container(
          color: Colors.redAccent,
          child: Text('map'),
        ),
      ),
    );
  }
}
