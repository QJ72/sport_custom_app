import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sport_custom_app/Presenter/parameters_messager.dart';
import 'package:sport_custom_app/View/workout.dart';

class InsideMainDrawer extends StatefulWidget {
  final Function(Widget) _onBodyChange;

  InsideMainDrawer(this._onBodyChange);

  @override
  State<StatefulWidget> createState() => _InsideMainDrawerState();

  Future<List<File>> getFiles(Directory directory) async {
    List<File> filesList = [];

    await for (FileSystemEntity entity in directory.list(
      recursive: true,
      followLinks: false,
    )) {
      filesList.add(entity as File);
    }

    print(directory);
    return filesList;
  }

  List<String> getFilesName(List<File> filesList) {
    List<String> namesList = [];

    print("inside getFilesName, filesList : $filesList ");

    for (var file in filesList) {
      print("file path : ${file.path}");
      namesList.add(file.path.split('/').last);
    }

    print("inside getFilesName $namesList");

    return namesList;
  }
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

    List<File> filesList = await widget.getFiles(directory);

    print("fileList just after getFiles : $filesList");

    List<String> namesList = widget.getFilesName(filesList);

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
