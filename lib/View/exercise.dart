import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sport_custom_app/View/serie.dart';

part '../Presenter/exercise.g.dart';

@JsonSerializable()
class Exercise extends StatefulWidget {
  Exercise(this.name, {List<Serie>? series}){
    if (series == null){
      this.series = [Serie()];
    } else {
      this.series = series;
    }
  }

  late final String name;
  late List<Serie> series;

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  @override
  State<StatefulWidget> createState() => _ExerciceState();
}

class _ExerciceState extends State<Exercise> {

  Row createSeriesRow(int index) {
    if (index == 0) {
      return Row(
        children: [
          Expanded(child: widget.series.elementAt(index)),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                widget.series.add(Serie());
              });
            },
            label: Text(''),
            icon: Icon(Icons.add),
            iconAlignment: IconAlignment.end,
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                widget.series.removeLast();
              });
            },
            label: Text(''),
            icon: Icon(Icons.remove),
            iconAlignment: IconAlignment.end,
          ),
        ],
      );
    }

    return Row(children: [Expanded(child: widget.series.elementAt(index))]);
  }

  List<Row> createListSeriesRow() {
    List<Row> result = [];

    if (widget.series.isEmpty) {
      result.add(
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  widget.series.add(Serie());
                });
              },
              label: Text(''),
              icon: Icon(Icons.add),
              iconAlignment: IconAlignment.end,
            ),
          ],
        ),
      );
    }

    for (int index = 0; index < widget.series.length; index++) {
      result.add(createSeriesRow(index));
    }

    return result;
  }

  @override
  Widget build(Object context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0), // Small padding
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple, width: 2), // Purple border
        borderRadius: BorderRadius.circular(16), // Smooth edges
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.name),
            ),
          ),
          Expanded(child: Column(children: createListSeriesRow())),
        ],
      ),
    );
  }
}
