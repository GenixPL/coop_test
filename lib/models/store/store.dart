import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class Store with EquatableMixin {
  String get id;
  String get name;
  String get newsletterUrl;
  double get lat;
  double get lon;

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
