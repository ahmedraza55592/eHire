import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:ehire_app/scr/widgets/AppButton.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          children: [
            SizedBox(
              height: height * .2,
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
                    Navigator.pushReplacementNamed(
                        context, MyRoutes.signupPage);
                  },
                  child: Text(
                    "SignUp",
                    style: TextStyles.buttonTextDark,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * .1,
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
              height: height * .04,
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
              height: height * .05,
            ),
            AppButton(
              buttonText: "Sign Up",
              buttonType: ButtonType.yellow,
            ),
          ],
        ),
      ),
    );
  }
}
