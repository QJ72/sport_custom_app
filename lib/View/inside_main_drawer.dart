import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sport_custom_app/Presenter/parameters_messager.dart';
import 'package:sport_custom_app/Presenter/workouts_manager.dart';
import 'package:sport_custom_app/View/workout.dart';

class InsideMainDrawer extends StatefulWidget {
  final Function(Widget) _onBodyChange;

  InsideMainDrawer(this._onBodyChange);

  final WorkoutsManager _workoutsManager = WorkoutsManager();

  @override
  State<StatefulWidget> createState() => _InsideMainDrawerState();

}

class _InsideMainDrawerState extends State<InsideMainDrawer> {

  List<ElevatedButton> templatesButtonList = [];
  List<ElevatedButton> workoutsButtonList = [];

  @override
  void initState() {
    super.initState();

    createFutureButtons(ParametersMessager.templatesDirectory).then( (list) {
      setState(() {
        templatesButtonList = list;
      });

    });
    
    createFutureButtons(ParametersMessager.workoutsDirectory).then( (list) {
      setState(() {
        workoutsButtonList = list;
      });
    });
  }
  
  Future<List<ElevatedButton>> createFutureButtons(Directory directory) async {
    List<ElevatedButton> buttonsList = [];

    List<File> filesList = await widget._workoutsManager.getFiles(directory);

    print("fileList just after getFiles : $filesList");

    List<String> namesList = widget._workoutsManager.getFilesName(filesList);

    print("fileList : $filesList");
    print("nameList : $namesList");

    for (int index = 0; index < filesList.length; index++) {
      buttonsList.add(
        ElevatedButton(
          onPressed: () async {
            final String contents =
                await filesList.elementAt(index).readAsString();
            final List<dynamic> jsonData =
                jsonDecode(contents) as List<dynamic>;

            widget._onBodyChange(Workout.fromJson(jsonData.elementAt(0)));
          },
          child: Text(namesList.elementAt(index)),
        ),
      );
    }

    return buttonsList;
  }
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Templates :"),
        Column( children: templatesButtonList,),
        Text("Workouts :"),
        Column(children: workoutsButtonList,),
      ],
    );
  }
}
