import 'package:ehire_app/scr/routes.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/widgets/AppButton.dart';
import 'package:flutter/material.dart';

class RoleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, MyRoutes.userLoginpage);
              },
              child: AppButton(
                  buttonText: "Looking for a Pro",
                  buttonType: ButtonType.brownblack),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, MyRoutes.serviceProviderLoginpage);
              },
              child: AppButton(
                buttonText: "Wanna Serve as a Pro",
                buttonType: ButtonType.brownblack,
              ),
            )
          ],
        ),
      ),
    );
  }
}
