import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme {
    return Theme.of(this);
  }
}
