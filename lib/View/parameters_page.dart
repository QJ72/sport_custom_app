import 'package:flutter/material.dart';
import 'package:sport_custom_app/Presenter/parameters_messager.dart';


class ParametersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ParameterPageState();
}

class _ParameterPageState extends State<ParametersPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('kg'),
          leading: Radio<WeightMetric>(
            value: WeightMetric.kg,
            groupValue: ParametersMessager.currentMetricChoice,
            onChanged: (WeightMetric? value) {
              setState(() {
                ParametersMessager.currentMetricChoice = value!;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('lb'),
          leading: Radio<WeightMetric>(
            value: WeightMetric.lb,
            groupValue: ParametersMessager.currentMetricChoice,
            onChanged: (WeightMetric? value) {
              setState(() {
                ParametersMessager.currentMetricChoice = value!;
              });
            },
          ),
        ),
      ],
    );
  }
}
