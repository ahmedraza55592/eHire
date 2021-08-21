import 'package:ehire_app/scr/styles/baseStyle.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search...",
          hintStyle: TextStyles.buttonTextDark,
          suffixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.black, width: BaseStyles.borderWidth),
              borderRadius: BorderRadius.circular(BaseStyles.borderRadius)),
        ),
      ),
    );
  }
}
