import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

abstract class GenProvider<T> extends ValueNotifier<T> {
  GenProvider(super.value);

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
