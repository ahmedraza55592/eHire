import 'package:ehire_app/scr/screens/userScreens/userHomepage.dart';
import 'package:ehire_app/scr/services/userDatabase.dart';
import 'package:ehire_app/scr/services/userFirestoreservice.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:ehire_app/scr/utils/constants.dart';
import 'package:ehire_app/scr/utils/sharedprefer_helper.dart';
import 'package:ehire_app/scr/widgets/AppButton.dart';
import 'package:ehire_app/scr/widgets/dialogbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController userEmailTextEditingController =
      TextEditingController();
  TextEditingController userPasswordTextEditingController =
      TextEditingController();
  TextEditingController userNameTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool agree = false;
  bool isLoading = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  AuthMethods authService = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  var confirmPass;

  signUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signUpWithEmailAndPassword(userEmailTextEditingController.text,
              userPasswordTextEditingController.text)
          .then((result) {
        if (result != null) {
          print("Before Mapping " + auth.currentUser.uid);
          Map<String, String> userDataMap = {
            "userId": auth.currentUser.uid,
            "userName": userNameTextEditingController.text,
            "userEmail": userEmailTextEditingController.text,
          };
          print("After Mapping " + auth.currentUser.uid);

          databaseMethods.addUserInfoToDB(auth.currentUser.uid, userDataMap);

          print("After Saving into Database " + auth.currentUser.uid);

          Constants.prefs.setBool("userLoggedIn", true);

          SharedPreferenceHelper.saveUserID(auth.currentUser.uid);
          SharedPreferenceHelper.saveUserName(
              userNameTextEditingController.text);
          SharedPreferenceHelper.saveUserEmail(
              userEmailTextEditingController.text);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => UserHomePage()));
        }
      });
    }
  }

  @override
  void dispose() {
    userEmailTextEditingController.dispose();
    userNameTextEditingController.dispose();
    userPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColors.white,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.brownblack),
            ),
          )
        : Material(
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
                        controller: userNameTextEditingController,
                        decoration: InputDecoration(
                            hintText: "Username",
                            hintStyle: TextStyles.buttonTextDark),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Username cannot be empty";
                          } else if (value.length < 4) {
                            return "username length should be atleast 4";
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
                        controller: userEmailTextEditingController,
                        decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyles.buttonTextDark),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Email cannot be empty";
                          } else if (!RegExp(
                                  "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
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
                          confirmPass = value;
                          if (value.isEmpty) {
                            return "Password cannot be empty";
                          } else if (value.length < 8) {
                            return "Password lenght should be altleast 8";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * .04,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Confirm Password",
                            hintStyle: TextStyles.buttonTextDark),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Confirm Password cannot be empty";
                          } else if (value.length < 8) {
                            return "Password lenght should be altleast 8";
                          } else if (value != confirmPass) {
                            return "Password must be same as above";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                            activeColor: AppColors.black,
                            value: agree,
                            onChanged: (value) {
                              setState(() {
                                agree = value;
                              });
                            }),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: "I agree with ",
                                  style: TextStyles.buttonTextDarkSmall,
                                  children: [
                                    TextSpan(
                                        text: "terms and conditions",
                                        style: TextStyles.link,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap =
                                              () => showTermsAndConditionsBox(context)),
                                  ])),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * .05,
                    ),
                    GestureDetector(
                      onTap: () {
                        agree ? signUp() : Container();
                      },
                      child: agree
                          ? AppButton(
                              buttonText: "Sign Up",
                              buttonType: ButtonType.brownblack,
                            )
                          : AppButton(
                              buttonText: "Sign Up",
                              buttonType: ButtonType.disableButton),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
