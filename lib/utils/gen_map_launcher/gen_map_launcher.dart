import 'package:coop_test/utils/_utils.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps_launcher/maps_launcher.dart';

class GenMapLauncher {
  const GenMapLauncher({
    required Logger logger,
  }) : _logger = logger;

  // region Dependencies

  final Logger _logger;

  // endregion

  Future<bool> launchLoc(LatLng latLng) async {
    try {
      return await MapsLauncher.launchCoordinates(latLng.latitude, latLng.longitude);
    } catch (e) {
      _logger.error('launchLoc, ');
      return false;
    }

    return true;
  }
}
