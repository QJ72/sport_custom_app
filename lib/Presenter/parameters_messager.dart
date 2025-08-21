enum WeightMetric { kg, lb }

class ParametersMessager {
  static WeightMetric currentMetricChoice = WeightMetric.kg;
  static List<String> weightMetricChoice = ["kg", "lb"];
  static String sourcesDirectory = "sources";
  static String workoutDirectory = "$sourcesDirectory/workouts";
  static String templateDirectory = "$sourcesDirectory/templates";

  static String getWeightMetricChoice(){
    return weightMetricChoice.elementAt(currentMetricChoice.index);
  }
} 