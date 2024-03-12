import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class Store with EquatableMixin {
  Store({
    required this.id,
    required this.name,
    required this.newsletterUrl,
    required this.lat,
    required this.lon,
  });

  final String id;
  final String name;
  final String newsletterUrl;
  final double lat;
  final double lon;

  late final LatLng latLng = LatLng(lat, lon);

  @override
  List<Object?> get props {
    return <Object?>[
      id,
      name,
      newsletterUrl,
      lat,
      lon,
    ];
  }
}
