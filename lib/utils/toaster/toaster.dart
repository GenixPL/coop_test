import 'package:coop_test/utils/_utils.dart';
import 'package:flutter/material.dart';

typedef ToasterKey = GlobalKey<ScaffoldMessengerState>;

class Toaster {
  const Toaster({
    required Logger logger,
  }) : _logger = logger;

  // region Dependencies

  final Logger _logger;

  // endregion

  // region Values

  static final ToasterKey _key = GlobalKey<ScaffoldMessengerState>();

  // endregion

  // region Exposed

  ToasterKey get key {
    return _key;
  }

  void showError(String text) {
    _showToast(
      text: text,
      color: Colors.redAccent,
    );
  }

  void showInfo(String text) {
    _showToast(
      text: text,
      color: null,
    );
  }

  // endregion

  // region Not Exposed

  void _showToast({
    required String text,
    required Color? color,
  }) {
    final ScaffoldMessengerState? state = key.currentState;
    if (state == null) {
      _logger.error('_showToast, state is null!');
      return;
    }

    state.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  // endregion
}
