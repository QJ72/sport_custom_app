import 'package:dart_duckdb/dart_duckdb.dart';
import 'package:sport_custom_app/Presenter/parameters_messager.dart';
import 'package:sport_custom_app/Presenter/workouts_manager.dart';
import 'package:sport_custom_app/View/exercise.dart';
import 'package:sport_custom_app/View/serie.dart';
import 'package:sport_custom_app/View/workout.dart';

class DatabaseManager {
  late final Database _database;
  late final Connection _connection;
  final String _exercisesTableName = "exercises";

  final WorkoutsManager _workoutsManager;

  DatabaseManager(this._workoutsManager) {
    initialize();
  }

  void initialize() async {
    _database = await duckdb.open(
      "${ParametersMessager.sourcesDirectory}/my_database.duckdb",
    );


    _connection = await duckdb.connect(_database);

    createAndInitiateExercisesTable();

    lookAtDatabase();
  }

  void createAndInitiateExercisesTable() async {

    await _connection.execute('''
      CREATE TABLE IF NOT EXISTS exercises (
        name VARCHAR,
        weight INT,
        repetitions INT,
      )
    ''');

    if  ((await _connection.query(
      "SELECT * FROM $_exercisesTableName;",
    )).rowCount != 0){
      return;
    }

    List<Workout> workoutsList = await _workoutsManager.getAllWorkoutsFromDirectory(ParametersMessager.workoutsDirectory);

    print("workoutList : $workoutsList ");

    for (var workout in workoutsList) {
      addWorkoutToDatabase(workout);
    }
    
  }

  void addWorkoutToDatabase(Workout workout){
    for (Exercise exercise in workout.exercises) {
      for (Serie serie in exercise.series) {
        _connection.execute('''
        INSERT INTO $_exercisesTableName (name, weight, repetitions)
        VALUES ( '${exercise.name}', ${serie.weight}, ${serie.repetitions} )
      ''');
      }
    }
  }

  void clearDatabase(){
    _connection.execute('''
      DROP TABLE exercises ;
    ''');
  }

  void lookAtDatabase() async {
    final ResultSet allExercises = await _connection.query(
      "SELECT * FROM $_exercisesTableName;",
    );

    print(allExercises.columnNames);
    print(allExercises.fetchAll());
    print(allExercises.rowCount);
  }
}
