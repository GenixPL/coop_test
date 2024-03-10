import 'package:coop_test/utils/_utils.dart';
import 'package:flutter/material.dart';

typedef NavKey = GlobalKey<NavigatorState>;

class PlaceTaker {
  const PlaceTaker({
    required Logger logger,
  }) : _logger = logger;

  // region Dependencies

  final Logger _logger;

  // endregion

  // region Values

  static final NavKey _key = GlobalKey<NavigatorState>();

  // endregion

  // region Exposed

  NavKey get navKey {
    return _key;
  }

  void pop<T extends Object?>([T? result]) {
    try {
      _key.currentState?.pop(result);
    } catch (e) {
      _logger.error('pop, error: $e');
    }
  }

  Future<T?> push<T extends Object?>(Route<T> route) async {
    try {
      return _key.currentState?.push(route);
    } catch (e) {
      _logger.error('push, error: $e');
      return null;
    }
  }

  // endregion
}
