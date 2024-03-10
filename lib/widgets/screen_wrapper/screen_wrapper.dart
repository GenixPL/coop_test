import 'package:coop_test/widgets/_widgets.dart';
import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({
    super.key,
    required this.appBar,
    required this.layout,
  });

  final AppBar? appBar;
  final Layout layout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: layout,
      ),
    );
  }
}
