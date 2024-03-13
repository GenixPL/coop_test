import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

sealed class HttpRequest with EquatableMixin {
  const HttpRequest({
    required this.timeout,
    required this.url,
  });

  final Duration timeout;
  final String url;

  @mustCallSuper
  @override
  List<Object?> get props {
    return <Object?>[
      timeout,
      url,
    ];
  }
}

class GetRequest extends HttpRequest {
  const GetRequest({
    required super.timeout,
    required super.url,
  });
}
