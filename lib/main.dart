import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sport_custom_app/View/parameters_page.dart';
import 'package:sport_custom_app/View/workout.dart';

void main() {
  runApp(MyApp());
}

class MyAppState extends ChangeNotifier {}

class MyApp extends StatelessWidget {
  late MainWindow _mainWindow;

  MyApp() {
    _mainWindow = MainWindow();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vikartographe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: _mainWindow,
    );
  }
}

class MainWindow extends StatefulWidget {
  late Widget _body;

  MainWindow() {
    _body = Workout();
  }
  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
  ElevatedButton createLoadWorkoutButton(BuildContext context) {
    return ElevatedButton.icon(
      label: Text('Load'),
      icon: Icon(Icons.file_open),
      iconAlignment: IconAlignment.end,
      onPressed: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['json'],
          allowMultiple: false,
        );

        if (result != null && result.files.single.path != null) {
        String filePath = result.files.single.path!;

        final File file = File(filePath);
        final String contents = await file.readAsString();
        final List<dynamic> jsonData = jsonDecode(contents) as List<dynamic>;

        setState(() {
          widget._body = Workout.fromJson(jsonData.elementAt(0));
        });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          createLoadWorkoutButton(context),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                widget._body = Workout();
              });
            },
            label: Text('Main Page'),
            icon: Icon(Icons.first_page),
            iconAlignment: IconAlignment.end,
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                widget._body = ParametersPage();
              });
            },
            label: Text(''),
            icon: Icon(Icons.settings),
            iconAlignment: IconAlignment.end,
          ),
        ],
      ),
      drawer: Drawer(),
      body: widget._body,
    );
  }
}
