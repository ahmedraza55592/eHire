import 'package:ehire_app/scr/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class TextStyles {
  // static TextStyle get body {
  //   return GoogleFonts.roboto(
  //       textStyle: TextStyle(color: AppColors.darkgray, fontSize: 16.0));
  // }

  // static TextStyle get link {
  //   return GoogleFonts.roboto(
  //       textStyle: TextStyle(
  //           color: AppColors.straw,
  //           fontSize: 16.0,
  //           fontWeight: FontWeight.bold));
  // }

  // static TextStyle get suggestion {
  //   return GoogleFonts.roboto(
  //       textStyle: TextStyle(color: AppColors.lightgray, fontSize: 14.0));
  // }

  static TextStyle get buttonTextLight {
    return GoogleFonts.lato(
        textStyle: TextStyle(
      color: Colors.white,
      fontSize: 17.0,
    ));
  }

  static TextStyle get buttonTextDark {
    return GoogleFonts.lato(
        textStyle: TextStyle(
      color: AppColors.black,
      fontSize: 17.0,
    ));
  }

  static TextStyle get buttonTextDarkSmall {
    return GoogleFonts.lato(
        textStyle: TextStyle(
      color: AppColors.black,
      fontSize: 14.0,
    ));
  }

  static TextStyle get buttonTextLightSmall {
    return GoogleFonts.lato(
        textStyle: TextStyle(
      color: AppColors.white,
      fontSize: 14.0,
    ));
  }

  static TextStyle get link {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            color: AppColors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold));
  }
}
