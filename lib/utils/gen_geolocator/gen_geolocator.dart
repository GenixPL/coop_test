import 'package:coop_test/utils/_utils.dart';
import 'package:geolocator/geolocator.dart';

class GenGeolocator {
  const GenGeolocator({
    required Logger logger,
  }) : _logger = logger;

  // region Dependencies

  final Logger _logger;

  // endregion

  Future<bool?> isServiceEnabled() async {
    try {
      return await Geolocator.isLocationServiceEnabled();
    } catch (e) {
      _logger.error('isServiceEnabled, error: $e');
      return null;
    }
  }

  Future<LocationPermission?> requestPermission() async {
    try {
      return await Geolocator.requestPermission();
    } catch (e) {
      _logger.error('requestPermission, error: $e');
      return null;
    }
  }

  Future<Position?> getCurrentPosition() async {
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      _logger.error('getCurrentPosition, error: $e');
      return null;
    }
  }
}
