import 'package:ehire_app/scr/routes.dart';
import 'package:ehire_app/scr/screens/serviceProviderScreens/serviceProviderLoginPage.dart';
import 'package:ehire_app/scr/screens/serviceProviderScreens/serviceProviderSignupPage.dart';
import 'package:ehire_app/scr/screens/userScreens/userLoginPage.dart';
import 'package:ehire_app/scr/screens/resetPassword.dart';
import 'package:ehire_app/scr/screens/roleSelectionScreen.dart';
import 'package:ehire_app/scr/screens/userScreens/signupPage.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "eHire App",
      home: RoleSelectionScreen(),
      routes: {
        MyRoutes.roleSelectionScreen: (context) => RoleSelectionScreen(),
        MyRoutes.userLoginpage: (context) => UserLoginPage(),
        MyRoutes.serviceProviderLoginpage: (context) =>
            ServiceProviderLoginPage(),
        MyRoutes.resetPassword: (context) => ResetPassword(),
        MyRoutes.signupPage: (context) => SignupPage(),
        MyRoutes.serviceProviderSignupPage: (context) => ServiceProviderSignupPage(),
      },
    );
  }
}
