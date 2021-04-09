import 'package:ehire_app/scr/styles/baseStyle.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:ehire_app/scr/styles/buttonStyles.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  final ButtonType buttonType;

  AppButton({@required this.buttonText, this.buttonType});

  @override
  Widget build(BuildContext context) {
    TextStyle fontStyle;
    Color buttonColor;

    switch (buttonType) {
      case ButtonType.yellow:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColors.yellow;
        break;
      case ButtonType.paypalButton:
        fontStyle = TextStyles.buttonTextDark;
        buttonColor = AppColors.paypalButton;
        break;
      default:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColors.yellow;
        break;
    }

    return Padding(
      padding: BaseStyles.listPadding,
      child: Container(
        height: ButtonStyles.buttonHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
            boxShadow: BaseStyles.boxShadow),
        child: Center(
            child: Text(
          buttonText,
          style: fontStyle,
        )),
      ),
    );
  }
}

enum ButtonType { yellow, paypalButton }
