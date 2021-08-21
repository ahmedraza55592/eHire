import 'package:ehire_app/scr/routes.dart';
import 'package:ehire_app/scr/screens/serviceProviderScreens/serviceProviderHomePage.dart';
import 'package:ehire_app/scr/screens/serviceProviderScreens/serviceProviderLoginPage.dart';
import 'package:ehire_app/scr/screens/serviceProviderScreens/serviceProviderSignupPage.dart';
import 'package:ehire_app/scr/screens/serviceProviderScreens/serviceProviderUpdateProfile.dart';
// import 'package:ehire_app/scr/screens/termsandcondtions.dart';
import 'package:ehire_app/scr/screens/userScreens/sericeProviderDetailScreen.dart';
import 'package:ehire_app/scr/screens/userScreens/userChatScreen.dart';
import 'package:ehire_app/scr/screens/userScreens/userHomepage.dart';
import 'package:ehire_app/scr/screens/userScreens/userFilterScreen.dart';
import 'package:ehire_app/scr/screens/userScreens/userLoginPage.dart';
import 'package:ehire_app/scr/screens/resetPassword.dart';
import 'package:ehire_app/scr/screens/roleSelectionScreen.dart';
import 'package:ehire_app/scr/screens/userScreens/signupPage.dart';
import 'package:ehire_app/scr/screens/userScreens/userUpdateProfile.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/utils/constants.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "eHire App",
      theme: ThemeData(primaryColor: AppColors.black),
      home: Constants.prefs.getBool("userLoggedIn") == true
          ? UserHomePage()
          : Constants.prefs.getBool("serviceProviderLoggedIn") == true
              ? ServiceProviderHomePage()
              : RoleSelectionScreen(),
      routes: {
        MyRoutes.roleSelectionScreen: (context) => RoleSelectionScreen(),
        MyRoutes.userLoginpage: (context) => UserLoginPage(),
        MyRoutes.serviceProviderLoginpage: (context) =>
            ServiceProviderLoginPage(),
        MyRoutes.resetPassword: (context) => ResetPassword(),
        MyRoutes.signupPage: (context) => SignupPage(),
        MyRoutes.serviceProviderSignupPage: (context) =>
            ServiceProviderSignupPage(),
        MyRoutes.userHomePage: (context) => UserHomePage(),
        MyRoutes.userUpdateProfile: (context) => UserUpdateProfile(),
        MyRoutes.userFilterScreen: (context) => UserFilterScreen(),
        MyRoutes.serviceProviderHomePage: (context) =>
            ServiceProviderHomePage(),
        MyRoutes.serviceProviderUpdateProfile: (context) =>
            ServiceProviderUpdateProfile(),
        MyRoutes.serviceProviderDetailScreen: (context) =>
            ServiceProviderDetailScreen(),
        MyRoutes.userChatScreen: (context) => UserChatScreen(),
        // MyRoutes.termsandconditions: (context) => TermsAndCondtions()
      },
    );
  }
}
