import 'package:coop_test/utils/_utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

enum GetLocationError {
  serviceDisabled,
  permissionsDenied,
  unknown,
}

typedef GetLocationResult = ({
  LatLng? latLng,
  GetLocationError? error,
});

// Setup: https://pub.dev/packages/geolocator#usage
class LocationProvider extends GenProvider<LatLng?> {
  LocationProvider({
    required Logger logger,
    required GenGeolocator genGeolocator,
  })  : _logger = logger,
        _geolocator = genGeolocator,
        super(null);

  // region Dependencies

  final Logger _logger;
  final GenGeolocator _geolocator;

  // endregion

  // region Exposed

  Future<GetLocationResult> getLocation() async {
    final bool? serviceEnabled = await _geolocator.isServiceEnabled();
    if (serviceEnabled == null) {
      return (
        latLng: null,
        error: GetLocationError.unknown,
      );
    }
    if (!serviceEnabled) {
      return (
        latLng: null,
        error: GetLocationError.serviceDisabled,
      );
    }

    final LocationPermission? permission = await _geolocator.requestPermission();
    switch (permission) {
      case LocationPermission.unableToDetermine:
      case null:
        return (
          latLng: null,
          error: GetLocationError.unknown,
        );

      case LocationPermission.denied:
      case LocationPermission.deniedForever:
        return (
          latLng: null,
          error: GetLocationError.permissionsDenied,
        );

      case LocationPermission.whileInUse:
      case LocationPermission.always:
        // Continue outside.
        break;
    }

    final Position? position = await _geolocator.getCurrentPosition();
    if (position == null) {
      return (
        latLng: null,
        error: GetLocationError.unknown,
      );
    }

    final LatLng latLng = LatLng(position.latitude, position.longitude);
    value = latLng;

    return (
      latLng: latLng,
      error: null,
    );
  }

  // endregion
}
