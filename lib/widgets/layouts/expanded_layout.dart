import 'package:coop_test/widgets/_widgets.dart';
import 'package:flutter/material.dart';

class ExpandedLayout extends Layout {
  const ExpandedLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: child,
        );
      },
    );
  }
}
