import 'package:coop_test/providers/_providers.dart';

abstract class GetLocationErrorMappers {
  const GetLocationErrorMappers._();

  static String getLocationErrorToString(GetLocationError? getLocationError) {
    switch (getLocationError) {
      case GetLocationError.serviceDisabled:
        return 'Location service is disabled.';

      case GetLocationError.permissionDenied:
        return 'Please give the app location permissions.';

      case null:
      case GetLocationError.unknown:
        return 'Something went wrong';
    }
  }
}
