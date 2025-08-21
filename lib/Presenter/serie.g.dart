// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../View/serie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Serie _$SerieFromJson(Map<String, dynamic> json) => Serie(
  weight: (json['weight'] as num?)?.toInt(),
  repetitions: (json['repetitions'] as num?)?.toInt(),
);

Map<String, dynamic> _$SerieToJson(Serie instance) => <String, dynamic>{
  'weight': instance.weight,
  'repetitions': instance.repetitions,
};
