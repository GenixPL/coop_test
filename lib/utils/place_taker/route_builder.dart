import 'package:flutter/material.dart';

abstract class RouteBuilder {
  const RouteBuilder._();

  static Route<T> defaultRoute<T>({
    required String routeName,
    required Widget screen,
  }) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) {
        return screen;
      },
    );
  }
}
