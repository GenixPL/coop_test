import 'package:coop_test/widgets/_widgets.dart';
import 'package:flutter/material.dart';

class ScrollableLayout extends Layout {
  const ScrollableLayout({
    super.key,
    required this.axis,
    required this.child,
  });

  final Axis axis;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          scrollDirection: axis,
          child: ConstrainedBox(
            constraints: _getConstraints(constraints),
            child: child,
          ),
        );
      },
    );
  }

  BoxConstraints _getConstraints(BoxConstraints constraints) {
    switch (axis) {
      case Axis.horizontal:
        return BoxConstraints(
          minWidth: constraints.maxWidth,
        );

      case Axis.vertical:
        return BoxConstraints(
          minHeight: constraints.maxHeight,
          minWidth: constraints.maxWidth,
          maxWidth: constraints.maxWidth,
        );
    }
  }
}
