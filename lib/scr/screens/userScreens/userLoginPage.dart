import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehire_app/scr/screens/userScreens/userHomepage.dart';
import 'package:ehire_app/scr/services/userDatabase.dart';
import 'package:ehire_app/scr/services/userFirestoreservice.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:ehire_app/scr/utils/constants.dart';
import 'package:ehire_app/scr/utils/sharedprefer_helper.dart';
import 'package:ehire_app/scr/widgets/AppButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes.dart';

class UserLoginPage extends StatefulWidget {
  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  TextEditingController userEmailTextEditingController =
      TextEditingController();
  TextEditingController userPasswordTextEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthMethods authService = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  FirebaseAuth auth = FirebaseAuth.instance;

  signIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signInWithEmailAndPassword(userEmailTextEditingController.text,
              userPasswordTextEditingController.text)
          .then((result) async {
        if (result != null) {
          QuerySnapshot userInfoSnapshot = await DatabaseMethods()
              .getUserInfo(userEmailTextEditingController.text);

          print(
              "Getting the userName snapshot with Id or only Id of current user " +
                  userInfoSnapshot.docs[0].id);

          print("User is Loggin in " + userInfoSnapshot.toString());

          print("Getting the userName snapshot " +
              userInfoSnapshot.docs[0].data()['userName']);


          Constants.prefs.setBool("userLoggedIn", true);

          SharedPreferenceHelper.saveUserEmail(
              userInfoSnapshot.docs[0].data()['userEmail']);

          SharedPreferenceHelper.saveUserName(
              userInfoSnapshot.docs[0].data()['userName']);

          SharedPreferenceHelper.saveUserID(
              userInfoSnapshot.docs[0].data()['userId']);

          SharedPreferenceHelper.saveUserAbout(
              userInfoSnapshot.docs[0].data()['about']);

          SharedPreferenceHelper.saveUserAddress(
              userInfoSnapshot.docs[0].data()['address']);

          SharedPreferenceHelper.saveProfilePic(
              userInfoSnapshot.docs[0].data()['profilePic']);

          // print("Profile Pic URL" +
          // userInfoSnapshot.docs[0].data()['profilePic']);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => UserHomePage()));
        } else {
          setState(() {
            isLoading = false;
            //show snackbar
          });
        }
      });
    }
  }

  @override
  void dispose() {
    userEmailTextEditingController.dispose();
    userPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
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
                  controller: userEmailTextEditingController,
                  decoration: InputDecoration(
                      hintText: "Email", hintStyle: TextStyles.buttonTextDark),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Email cannot be empty";
                    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return "Please Enter a valid email";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  obscureText: true,
                  controller: userPasswordTextEditingController,
                  decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyles.buttonTextDark),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Password cannot be empty";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              InkWell(
                onTap: () {
                  signIn();
                },
                child: AppButton(
                  buttonText: "Login",
                  buttonType: ButtonType.brownblack,
                ),
              ),
              SizedBox(
                height: height * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, MyRoutes.resetPassword);
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
      ),
    );
  }
}
