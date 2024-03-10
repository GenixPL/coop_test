import 'package:equatable/equatable.dart';

sealed class HttpError with EquatableMixin {
  const HttpError();
}

class HttpNoInternetError extends HttpError {
  const HttpNoInternetError();

  @override
  List<Object?> get props {
    return <Object?>[];
  }
}
