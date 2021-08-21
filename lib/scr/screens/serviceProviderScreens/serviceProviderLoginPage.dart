import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehire_app/scr/screens/serviceProviderScreens/serviceProviderHomePage.dart';
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

class ServiceProviderLoginPage extends StatefulWidget {
  @override
  _ServiceProviderLoginPageState createState() =>
      _ServiceProviderLoginPageState();
}

class _ServiceProviderLoginPageState extends State<ServiceProviderLoginPage> {
  TextEditingController serviceProviderEmailTextEditingController =
      TextEditingController();
  TextEditingController serviceProviderPasswordTextEditingController =
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
          .signInWithEmailAndPassword(
              serviceProviderEmailTextEditingController.text,
              serviceProviderPasswordTextEditingController.text)
          .then((result) async {
        if (result != null) {
          QuerySnapshot serviceProviderInfoSnapshot = await DatabaseMethods()
              .getServiceProviderInfo(
                  serviceProviderEmailTextEditingController.text);

          print(
              "Getting the serviceProvider userName snapshot with Id or only Id of current user " +
                  serviceProviderInfoSnapshot.docs[0].id);

          print("serviceProvider User is Loggin in " +
              serviceProviderInfoSnapshot.toString());

          print("Getting the serviceProvider userName snapshot " +
              serviceProviderInfoSnapshot.docs[0]
                  .data()['serviceProviderName']);

          Constants.prefs.setBool("serviceProviderLoggedIn", true);

          SharedPreferenceHelper.saveServiceProviderEmail(
              serviceProviderInfoSnapshot.docs[0]
                  .data()['serviceProviderEmail']);

          SharedPreferenceHelper.saveServiceProviderName(
              serviceProviderInfoSnapshot.docs[0]
                  .data()['serviceProviderName']);

          SharedPreferenceHelper.saveServiceProviderID(
              serviceProviderInfoSnapshot.docs[0].data()['serviceProviderId']);

          SharedPreferenceHelper.saveServiceProviderAbout(
              serviceProviderInfoSnapshot.docs[0].data()['about']);

          SharedPreferenceHelper.saveServiceProviderAddress(
              serviceProviderInfoSnapshot.docs[0].data()['address']);

          SharedPreferenceHelper.saveServiceProviderProfilePic(
              serviceProviderInfoSnapshot.docs[0]
                  .data()['serviceProviderProfilePic']);

          // print("Profile Pic link " +
          //     serviceProviderInfoSnapshot.docs[0]
          //         .data()['serviceProviderProfilePic']);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ServiceProviderHomePage()));

          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => ServiceProviderHomePage(
          //               uid: serviceProviderInfoSnapshot.docs[0].id,
          //               userName: serviceProviderInfoSnapshot.docs[0]
          //                   .data()['serviceProviderName'],
          //               address: serviceProviderInfoSnapshot.docs[0]
          //                   .data()['serviceProvideraddress'],
          //               about: serviceProviderInfoSnapshot.docs[0]
          //                   .data()['serviceProviderabout'],
          //             )));
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
    serviceProviderEmailTextEditingController.dispose();
    serviceProviderPasswordTextEditingController.dispose();
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
                  controller: serviceProviderEmailTextEditingController,
                  decoration: InputDecoration(
                      hintText: "Email", hintStyle: TextStyles.buttonTextDark),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Username cannot be empty";
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
                  controller: serviceProviderPasswordTextEditingController,
                  obscureText: true,
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
      ),
    );
  }
}
