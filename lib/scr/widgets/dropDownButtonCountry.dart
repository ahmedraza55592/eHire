import 'package:ehire_app/scr/styles/baseStyle.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:flutter/material.dart';

class DropDownButtonWidgetCountry extends StatelessWidget {
  final String valueChoose;
  final Function toggleValueChoose;

  DropDownButtonWidgetCountry({this.valueChoose, this.toggleValueChoose});

  @override
  Widget build(BuildContext context) {
    List listItem = [
      "USA",
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.black, width: 0.5),
          borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
        ),
        child: DropdownButton(
            iconEnabledColor: AppColors.black,
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
            onChanged: toggleValueChoose,
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
