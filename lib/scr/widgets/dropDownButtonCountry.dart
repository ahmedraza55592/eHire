import 'package:ehire_app/scr/styles/baseStyle.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:flutter/material.dart';

class DropDownButtonWidgetCountry extends StatefulWidget {
  @override
  _DropDownButtonWidgetCountryState createState() =>
      _DropDownButtonWidgetCountryState();
}

class _DropDownButtonWidgetCountryState
    extends State<DropDownButtonWidgetCountry> {
  String valueChoose;
  List listItem = [
    "USA",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.black, width: 0.5),
          borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
        ),
        child: DropdownButton(
            hint: Text(
              "Select Country",
              style: TextStyles.buttonTextDark,
            ),
            dropdownColor: AppColors.white,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 36,
            isExpanded: true,
            underline: SizedBox(),
            value: valueChoose,
            onChanged: (newValue) {
              setState(() {
                valueChoose = newValue;
              });
            },
            items: listItem.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem),
              );
            }).toList()),
      ),
    );
  }
}
