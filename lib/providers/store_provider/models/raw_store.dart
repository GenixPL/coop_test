import 'package:coop_test/providers/_providers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'raw_store.g.dart';

@JsonSerializable()
class RawStore {
  const RawStore({
    required this.id,
    required this.name,
    required this.newsletterUrl,
    required this.lon,
    required this.lat,
  });

  // region Json

  factory RawStore.fromJson(Map<String, dynamic> json) {
    return _$RawStoreFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RawStoreToJson(this);

  // endregion

  @JsonKey(name: 'StoreId')
  final String id;

  @JsonKey(name: 'Name')
  final String name;

  @JsonKey(name: 'NewspaperUrl')
  final String newsletterUrl;

  @JsonKey(name: 'Lat')
  final double lat;

  @JsonKey(name: 'Lng')
  final double lon;

  Store toStore() {
    return Store(
      id: id,
      name: name,
      newsletterUrl: newsletterUrl,
      lat: lat,
      lon: lon,
    );
  }
}
