import 'dart:convert';

extension StringExtensions on String {
  Map<String, dynamic>? toJsonMap() {
    try {
      return jsonDecode(this) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  List<dynamic>? toJsonList() {
    try {
      return jsonDecode(this) as List<dynamic>;
    } catch (e) {
      return null;
    }
  }
}
