import 'package:ehire_app/scr/styles/baseStyle.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:flutter/material.dart';

class FilterChipWidget extends StatelessWidget {
  final String chipName;
  final Function toggleChipState;
  final bool isSelected;

  FilterChipWidget({this.chipName, this.toggleChipState, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(chipName),
      labelStyle:
          isSelected ? TextStyles.buttonTextLight : TextStyles.buttonTextDark,
      selected: isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
      ),
      selectedShadowColor: AppColors.black,
      shadowColor: AppColors.black,
      backgroundColor: AppColors.lightBlack,
      onSelected: toggleChipState,
      selectedColor: AppColors.brownblack,
    );
  }
}
