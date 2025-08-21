// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../View/workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) => Workout(
  exercises:
      (json['exercises'] as List<dynamic>?)
          ?.map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
  'exercises': instance.exercises,
};
