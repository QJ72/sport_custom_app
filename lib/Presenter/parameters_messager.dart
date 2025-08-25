import 'dart:io';

enum WeightMetric { kg, lb }

class ParametersMessager {
  static WeightMetric currentMetricChoice = WeightMetric.kg;
  static List<String> weightMetricChoice = ["kg", "lb"];
  static String sourcesDirectory = "ressources";
  static String workoutsPath = "$sourcesDirectory/workouts";
  static String templatesPath = "$sourcesDirectory/templates";

  static Directory workoutsDirectory = Directory(workoutsPath);
  static Directory templatesDirectory = Directory(templatesPath);

  static String getWeightMetricChoice(){
    return weightMetricChoice.elementAt(currentMetricChoice.index);
  }
} 