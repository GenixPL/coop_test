import 'package:coop_test/providers/_providers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'raw_store.g.dart';

@JsonSerializable()
class RawStore extends Store {
  RawStore({
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

  @override
  @JsonKey(name: 'StoreId')
  final String id;

  @override
  @JsonKey(name: 'Name')
  final String name;

  @override
  @JsonKey(name: 'NewspaperUrl')
  final String newsletterUrl;

  @override
  @JsonKey(name: 'Lat')
  final double lat;

  @override
  @JsonKey(name: 'Lng')
  final double lon;
}
