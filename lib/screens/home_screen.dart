import 'package:coop_test/widgets/_widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: null,
      layout: ScrollableLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GenTextButton(
              text: 'A',
              onTap: () {
                print('A');
              },
            ),
            GenTextButton(
              text: 'B',
              onTap: () {
                print('B');
              },
            ),
          ],
        ),
      ),
    );
  }
}
