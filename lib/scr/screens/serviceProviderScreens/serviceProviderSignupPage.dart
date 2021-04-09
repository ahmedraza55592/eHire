import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:ehire_app/scr/widgets/AppButton.dart';
import 'package:ehire_app/scr/widgets/dropDownButtonCity.dart';
import 'package:ehire_app/scr/widgets/dropDownButtonCountry.dart';
import 'package:ehire_app/scr/widgets/filterChipWidget.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

class ServiceProviderSignupPage extends StatefulWidget {
  @override
  _ServiceProviderSignupPageState createState() =>
      _ServiceProviderSignupPageState();
}

class _ServiceProviderSignupPageState extends State<ServiceProviderSignupPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Material(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        children: [
          SizedBox(
            height: height * .1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, MyRoutes.userLoginpage);
                },
                child: Text(
                  "Login",
                  style: TextStyles.buttonTextDark,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Container(
                height: 20.0,
                width: 1.0,
                color: AppColors.black,
              ),
              SizedBox(
                width: 8.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, MyRoutes.signupPage);
                },
                child: Text(
                  "SignUp",
                  style: TextStyles.buttonTextDark,
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * .05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Email", hintStyle: TextStyles.buttonTextDark),
            ),
          ),
          SizedBox(
            height: height * .02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Password", hintStyle: TextStyles.buttonTextDark),
            ),
          ),
          SizedBox(
            height: height * .02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Confirm Password",
                  hintStyle: TextStyles.buttonTextDark),
            ),
          ),
          SizedBox(
            height: height * .02,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Select Services you want to offer:",
                  style: TextStyles.buttonTextDark,
                ),
              )
            ],
          ),
          SizedBox(
            height: height * .015,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Wrap(
              spacing: 15.0,
              runSpacing: 2.0,
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
            height: height * .015,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Select Time",
                  style: TextStyles.buttonTextDark,
                ),
              )
            ],
          ),
          SizedBox(
            height: height * .015,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Wrap(
              spacing: 15.0,
              runSpacing: 2.0,
              children: [
                FilterChipWidget(
                  chipName: "10am to 14pm",
                ),
                FilterChipWidget(
                  chipName: "14pm to 18pm",
                ),
                FilterChipWidget(
                  chipName: "18pm to 24am",
                ),
                FilterChipWidget(
                  chipName: "24am to 10pm",
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Select Price :",
                  style: TextStyles.buttonTextDark,
                ),
              )
            ],
          ),
          SizedBox(
            height: height * .02,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Connect your Account :",
                  style: TextStyles.buttonTextDark,
                ),
              )
            ],
          ),
          AppButton(
            buttonText: "Paypal",
            buttonType: ButtonType.paypalButton,
          ),
          SizedBox(
            height: height * .03,
          ),
          AppButton(
            buttonText: "Sign Up",
            buttonType: ButtonType.yellow,
          ),
        ],
      ),
    );
  }
}
