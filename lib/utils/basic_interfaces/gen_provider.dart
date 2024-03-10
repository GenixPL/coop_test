import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

abstract class GenProvider extends ChangeNotifier {
  bool _wasInitialised = false;

  @protected
  void init() {}

  @override
  void addListener(VoidCallback listener) {
    if (!_wasInitialised) {
      _wasInitialised = true;
      init();
    }

    super.addListener(listener);
  }
}
