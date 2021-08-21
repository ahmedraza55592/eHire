import 'package:ehire_app/scr/styles/colors.dart';
import 'package:flutter/material.dart';

class RangerSliderWidget extends StatefulWidget {
  @override
  _RangerSliderWidgetState createState() => _RangerSliderWidgetState();
}

class _RangerSliderWidgetState extends State<RangerSliderWidget> {
  RangeValues _currentRangeValues = const RangeValues(30, 70);

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: _currentRangeValues,
      min: 5,
      max: 100,
      divisions: 100,
      activeColor: AppColors.white,
      inactiveColor: AppColors.black,
      labels: RangeLabels(
        _currentRangeValues.start.round().toString(),
        _currentRangeValues.end.round().toString(),
      ),
      onChanged: (values) {
        setState(() {
          _currentRangeValues = values;
        });
      },
    );
  }
}
