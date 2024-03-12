import 'package:coop_test/utils/_utils.dart';
import 'package:url_launcher/url_launcher.dart' as u;
import 'package:url_launcher/url_launcher_string.dart';

class GenUrlLauncher {
  const GenUrlLauncher({
    required Logger logger,
  }) : _logger = logger;

  // region Dependencies

  final Logger _logger;

  // endregion

  Future<bool> launch(String url) async {
    try {
      return await u.launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      _logger.error('launchLoc, error: $e');
      return false;
    }
  }
}
