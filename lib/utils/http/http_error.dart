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
