import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sport_custom_app/Presenter/parameters_messager.dart';

part '../Presenter/serie.g.dart';

@JsonSerializable()
class Serie extends StatefulWidget {
  int? weight;
  int? repetitions;

  Serie({this.weight, this.repetitions});

  factory Serie.fromJson(Map<String, dynamic> json) => _$SerieFromJson(json);

  Map<String, dynamic> toJson() => _$SerieToJson(this);

  @override
  State<StatefulWidget> createState() => _SerieState();
}

class _SerieState extends State<Serie> {

  late TextEditingController _serieWeightController;
  late TextEditingController _serieRepetitionController;
  
  @override
  void initState() {
    super.initState();
    _serieWeightController = TextEditingController(
      text: widget.weight?.toString() ?? '',
    );
    _serieWeightController.addListener(() {
      widget.weight = int.tryParse(_serieWeightController.text);
    });

    _serieRepetitionController = TextEditingController(
      text: widget.repetitions?.toString() ?? '',
    );
    _serieRepetitionController.addListener(() {
      widget.repetitions = int.tryParse(_serieRepetitionController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _serieRepetitionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Repetitions',
              ),
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _serieWeightController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Weight',
              ),
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
        ),
        Expanded(child: Text(ParametersMessager.getWeightMetricChoice())),
      ],
    );
  }
}
