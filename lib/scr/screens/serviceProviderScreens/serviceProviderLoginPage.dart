import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:ehire_app/scr/widgets/AppButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes.dart';

class ServiceProviderLoginPage extends StatefulWidget {
  @override
  _ServiceProviderLoginPageState createState() =>
      _ServiceProviderLoginPageState();
}

class _ServiceProviderLoginPageState extends State<ServiceProviderLoginPage> {
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
                        context, MyRoutes.serviceProviderLoginpage);
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
                        context, MyRoutes.serviceProviderSignupPage);
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
              height: height * .05,
            ),
            AppButton(
              buttonText: "Login",
              buttonType: ButtonType.yellow,
            ),
            SizedBox(
              height: height * .03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, MyRoutes.resetPassword);
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: GoogleFonts.lato().fontFamily),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
