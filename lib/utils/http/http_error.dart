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

class HttpNoInternetError extends HttpError {
  const HttpNoInternetError();

  @override
  List<Object?> get props {
    return <Object?>[];
  }
}
