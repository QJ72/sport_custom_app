import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sport_custom_app/Presenter/parameters_messager.dart';
import 'package:sport_custom_app/Presenter/workouts_manager.dart';
import 'package:sport_custom_app/View/exercise.dart';

part '../Presenter/workout.g.dart';

@JsonSerializable()
class Workout extends StatefulWidget {
  final WorkoutsManager workoutsManager = WorkoutsManager();
  late List<Exercise> exercises;

  Workout({List<Exercise>? exercises}) {
    if (exercises == null) {
      this.exercises = [];
    } else {
      this.exercises = exercises;
    }
  }

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutToJson(this);

  @override
  State<StatefulWidget> createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  late TextEditingController _exerciseNameInputController;
  late TextEditingController _templateNameInputController;
  @override
  void initState() {
    super.initState();
    _exerciseNameInputController = TextEditingController();
    _templateNameInputController = TextEditingController();
  }

  String _capitalizeWords(String input) {
    return input
        .split(' ')
        .map((str) {
          if (str.isEmpty) return str;
          return str[0].toUpperCase() + str.substring(1).toLowerCase();
        })
        .join(' ');
  }

  Row createExercicesRow(int index) {
    return Row(
      children: [
        Expanded(child: widget.exercises.elementAt(index)),
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              widget.exercises.removeAt(index);
            });
          },
          label: Text(''),
          icon: Icon(Icons.remove),
          iconAlignment: IconAlignment.end,
        ),
      ],
    );
  }

  List<Row> createListExercisesRow() {
    List<Row> result = [];

    for (int index = 0; index < widget.exercises.length; index++) {
      result.add(createExercicesRow(index));
    }

    return result;
  }

  ElevatedButton createAddExerciseButton(BuildContext context) {
    return ElevatedButton.icon(
      label: Text(''),
      icon: Icon(Icons.add),
      iconAlignment: IconAlignment.end,
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Add Exercise'),
              content: TextField(
                controller: _exerciseNameInputController,
                autofocus: true,
                decoration: InputDecoration(hintText: 'Exercise name'),
                textCapitalization: TextCapitalization.words,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_exerciseNameInputController.text.trim().isNotEmpty) {
                      setState(() {
                        widget.exercises.add(
                          Exercise(
                            _capitalizeWords(
                              _exerciseNameInputController.text.trim(),
                            ),
                          ),
                        );
                        _exerciseNameInputController.clear();
                      });
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  ElevatedButton createSaveWorkoutButton(BuildContext context) {
    return ElevatedButton.icon(
      label: Text('save Workout'),
      icon: Icon(Icons.save),
      iconAlignment: IconAlignment.end,
      onPressed: () {
        setState(() {

          widget.workoutsManager.saveWorkout(widget);

          widget.exercises.clear();
          _exerciseNameInputController.clear();
        });
      },
    );
  }

  ElevatedButton createSaveTemplateButton(BuildContext context) {
    return ElevatedButton.icon(
      label: Text('save as Template'),
      icon: Icon(Icons.save_as),
      iconAlignment: IconAlignment.end,
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Save Template'),
              content: TextField(
                controller: _templateNameInputController,
                autofocus: true,
                decoration: InputDecoration(hintText: 'Template name'),
                textCapitalization: TextCapitalization.words,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_templateNameInputController.text.trim().isNotEmpty) {
                      setState(() {
                        List<Workout> workoutsList = [widget];

                        final File file = File(
                          '${ParametersMessager.templatesPath}/${ _capitalizeWords(_templateNameInputController.text)}.json',
                        );
                        String json = jsonEncode(workoutsList);

                        file.writeAsStringSync(json, mode: FileMode.writeOnly);

                        widget.exercises.clear();
                        _templateNameInputController.clear();
                      });
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(children: createListExercisesRow()),
          Center(child: createAddExerciseButton(context)),
          Center(child: createSaveWorkoutButton(context)),
          Center(child: createSaveTemplateButton(context)),
        ],
      ),
    );
  }
}
