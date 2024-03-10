import 'package:equatable/equatable.dart';

class Store with EquatableMixin {
  const Store({
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
