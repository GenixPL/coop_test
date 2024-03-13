import 'package:coop_test/providers/_providers.dart';
import 'package:coop_test/utils/_utils.dart';

abstract class FindStoreFetchErrorMappers {
  const FindStoreFetchErrorMappers._();

  static String findStoreFetchErrorToString(FindStoreFetchError? error) {
    switch (error) {
      case null:
        return 'Something went wrong';

      case FindStoreFetchInProgressError():
        return 'Please wait for the previous request to finish.';

      case FindStoreFetchFailedFetchError():
        return HttpErrorMappers.httpErrorToString(error.httpError);
    }
  }
}
