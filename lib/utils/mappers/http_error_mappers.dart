import 'package:coop_test/utils/_utils.dart';

abstract class HttpErrorMappers {
  const HttpErrorMappers._();

  static String httpErrorToString(HttpError? error) {
    switch (error) {
      case null:
      case HttpUnknownError():
        return 'Something went wrong';

      case HttpTimeoutError():
        return 'The request has timed out.';

      case HttpCodeError():
        return 'Response code (${error.statusCode}) indicates an error.';

      case HttpNoInternetError():
        return 'No access to the internet.';

      case HttpParseError():
        return 'Response has invalid format.';

      case HttpWrongUrlError():
        return 'Request url could not be parsed.';
    }
  }
}
