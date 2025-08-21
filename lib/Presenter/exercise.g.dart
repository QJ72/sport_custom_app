// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../View/exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
  json['name'] as String,
  series:
      (json['series'] as List<dynamic>?)
          ?.map((e) => Serie.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
  'name': instance.name,
  'series': instance.series,
};
