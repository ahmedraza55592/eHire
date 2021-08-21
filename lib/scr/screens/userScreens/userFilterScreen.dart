import 'package:ehire_app/scr/styles/baseStyle.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:ehire_app/scr/widgets/AppButton.dart';
import 'package:ehire_app/scr/widgets/dropDownButtonCity.dart';
import 'package:ehire_app/scr/widgets/dropDownButtonCountry.dart';
import 'package:ehire_app/scr/widgets/filterChipWidget.dart';
import 'package:flutter/material.dart';

class UserFilterScreen extends StatefulWidget {
  @override
  _UserFilterScreenState createState() => _UserFilterScreenState();
}

class _UserFilterScreenState extends State<UserFilterScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      color: Color(0xff757575),
      child: Container(
        height: height * .7,
        decoration: BoxDecoration(
            color: AppColors.greenBlue,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(BaseStyles.borderRadius),
                topRight: Radius.circular(BaseStyles.borderRadius))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * .1,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Select Services you want to offer:",
                    style: TextStyles.buttonTextLight,
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * .015,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Wrap(
                spacing: 10.0,
                runSpacing: 0.0,
                children: [
                  FilterChipWidget(
                    chipName: "Gardener",
                  ),
                  FilterChipWidget(
                    chipName: "House Cleaner",
                  ),
                  FilterChipWidget(
                    chipName: "Drain Pipe Cleaner",
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * .02,
            ),
            DropDownButtonWidgetCountry(),
            SizedBox(
              height: height * .02,
            ),
            DropDownButtonWidgetCity(),
            SizedBox(
              height: height * .02,
            ),
            InkWell(
              onTap: () {},
              child: AppButton(
                buttonText: "Apply Filter",
                buttonType: ButtonType.brownblack,
              ),
            ),
            SizedBox(
              height: height * .01,
            ),
            InkWell(
              onTap: () {},
              child: AppButton(
                buttonText: "Clear Filter",
                buttonType: ButtonType.brownblack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
