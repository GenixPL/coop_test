import 'package:equatable/equatable.dart';

sealed class HttpError with EquatableMixin {
  const HttpError();
}

class HttpUnknownError extends HttpError {
  const HttpUnknownError();

  @override
  List<Object?> get props {
    return <Object?>[];
  }
}

class HttpTimeoutError extends HttpError {
  const HttpTimeoutError();

  @override
  List<Object?> get props {
    return <Object?>[];
  }
}

// For now not emitted by the client, but it's a
// frequent thing so it's been put here.
class HttpCodeError extends HttpError {
  const HttpCodeError({
    required this.statusCode,
  });

  final int statusCode;

  @override
  List<Object?> get props {
    return <Object?>[
      statusCode,
    ];
  }
}

class HttpNoInternetError extends HttpError {
  const HttpNoInternetError();

  @override
  List<Object?> get props {
    return <Object?>[];
  }
}

class HttpParseError extends HttpError {
  const HttpParseError();

  @override
  List<Object?> get props {
    return <Object?>[];
  }
}

/// [url] could not be parsed to [Uri].
class HttpWrongUrlError extends HttpError {
  const HttpWrongUrlError({
    required this.url,
  });

  final String url;

  @override
  List<Object?> get props {
    return <Object?>[
      url,
    ];
  }
}
