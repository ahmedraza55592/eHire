import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:ehire_app/scr/widgets/AppButton.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            SizedBox(
              height: height * .15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Forget Password",
                  style: TextStyles.buttonTextDark,
                ),
              ],
            ),
            SizedBox(
              height: height * .2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Email", hintStyle: TextStyles.buttonTextDark),
              ),
            ),
            SizedBox(
              height: height * .035,
            ),
            AppButton(
              buttonText: "Send Email!",
              buttonType: ButtonType.yellow,
            )
          ],
        ),
      ),
    );
  }
}
