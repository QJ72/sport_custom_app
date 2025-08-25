import 'dart:convert';
import 'dart:io';

import 'package:sport_custom_app/Model/database_manager.dart';
import 'package:sport_custom_app/Presenter/parameters_messager.dart';
import 'package:sport_custom_app/View/workout.dart';

class WorkoutsManager {
  late final DatabaseManager databaseManager;

  WorkoutsManager() {
    databaseManager = DatabaseManager(this);
  }

  Future<List<File>> getFiles(Directory directory) async {
    List<File> filesList = [];

    await for (FileSystemEntity entity in directory.list(
      recursive: true,
      followLinks: false,
    )) {
      filesList.add(entity as File);
    }

    return filesList;
  }

  List<String> getFilesName(List<File> filesList) {
    return filesList.map((File file) => file.path.split('/').last).toList();
  }

  List<String> getFilesPath(List<File> filesList) {
    return filesList.map((File file) => file.path).toList();
  }

  void saveWorkout(Workout workoutToSave) {
    final now = DateTime.now();

    final fileName = '${now.year}-${now.month}-${now.day}';

    final File file = File('${ParametersMessager.workoutsPath}/$fileName.json');

    List<dynamic> workoutsList = [];

    if (file.existsSync()) {
      final String content = file.readAsStringSync();
      if (content.trim().isNotEmpty) {
        workoutsList = jsonDecode(content);
      }
    }

    workoutsList.add(workoutToSave);
    String json = jsonEncode(workoutsList);

    file.writeAsStringSync(json, mode: FileMode.writeOnly);
  }

  Future<List<dynamic>> readJsonWorkoutFile(String filePath) async {
    final File file = File(filePath);
    final String contents = await file.readAsString();
    return jsonDecode(contents) as List<dynamic>;
  }

  Future<List<Workout>> getWorkoutsFromFile(String filePath) async {
    List<dynamic> jsonData = await readJsonWorkoutFile(filePath);

    return jsonData.map((json) => Workout.fromJson(json)).toList();
  }

  Future<List<Workout>> getAllWorkoutsFromDirectory(Directory directory) async {
    List<File> files = await getFiles(directory);
    List<String> paths = getFilesPath(files);

    List<Workout> workoutsList =  [];

    for (String filePath in paths){
      workoutsList.addAll( await getWorkoutsFromFile(filePath) );
    }


    return workoutsList;
  }
}