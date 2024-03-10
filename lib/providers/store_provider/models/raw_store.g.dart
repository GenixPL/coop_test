// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawStore _$RawStoreFromJson(Map<String, dynamic> json) => RawStore(
      id: json['StoreId'] as String,
      name: json['Name'] as String,
      newsletterUrl: json['NewspaperUrl'] as String,
      lon: (json['Lng'] as num).toDouble(),
      lat: (json['Lat'] as num).toDouble(),
    );

Map<String, dynamic> _$RawStoreToJson(RawStore instance) => <String, dynamic>{
      'StoreId': instance.id,
      'Name': instance.name,
      'NewspaperUrl': instance.newsletterUrl,
      'Lat': instance.lat,
      'Lng': instance.lon,
    };
