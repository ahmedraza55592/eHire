import 'package:ehire_app/scr/models/skills.dart';
import 'package:ehire_app/scr/screens/serviceProviderScreens/serviceProviderHomePage.dart';
import 'package:ehire_app/scr/services/userDatabase.dart';
import 'package:ehire_app/scr/services/userFirestoreservice.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:ehire_app/scr/utils/constants.dart';
import 'package:ehire_app/scr/widgets/AppButton.dart';
import 'package:ehire_app/scr/widgets/dialogbox.dart';
import 'package:ehire_app/scr/widgets/dropDownButtonCity.dart';
import 'package:ehire_app/scr/widgets/dropDownButtonCountry.dart';
import 'package:ehire_app/scr/widgets/filterChipWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

class ServiceProviderSignupPage extends StatefulWidget {
  // final String countryValueSelected, cityValueSelected;

  // const ServiceProviderSignupPage(
  //     {Key key, this.countryValueSelected, this.cityValueSelected})
  //     : super(key: key);
  @override
  _ServiceProviderSignupPageState createState() =>
      _ServiceProviderSignupPageState();
}

class _ServiceProviderSignupPageState extends State<ServiceProviderSignupPage> {
  TextEditingController serviceProviderEmailTextEditingController =
      TextEditingController();
  TextEditingController serviceProviderPasswordTextEditingController =
      TextEditingController();
  TextEditingController serviceProviderNameTextEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool agree = false;
  bool isLoading = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  AuthMethods authService = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  String countrySelected;
  String citySelected;

  bool _isSelected0 = false, _isSelected1 = false, _isSelected2 = false;

  List<Skill> skill = [
    Skill(name: "Gardener"),
    Skill(name: "House Cleaner"),
    Skill(name: "Drain Pipe Cleaner"),
  ];

  var confirmPass;

  signUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signUpWithEmailAndPassword(
              serviceProviderEmailTextEditingController.text,
              serviceProviderPasswordTextEditingController.text)
          .then((result) {
        if (result != null) {
          print("Before Mapping " + auth.currentUser.uid);
          Map<String, dynamic> serviceProviderDataMap = {
            "serviceProviderId": auth.currentUser.uid,
            "serviceProviderName":
                serviceProviderNameTextEditingController.text,
            "serviceProviderEmail":
                serviceProviderEmailTextEditingController.text,
            "city": citySelected,
            "country": countrySelected,
            "skill": [
              _isSelected0 == true ? skill[0].name : "",
              _isSelected1 == true ? skill[1].name : "",
              _isSelected2 == true ? skill[2].name : ""
            ],
          };
          print("After Mapping " + auth.currentUser.uid);

          databaseMethods.addServiceProviderInfoToDB(
              auth.currentUser.uid, serviceProviderDataMap);

          print("After Saving into Database " + auth.currentUser.uid);

          Constants.prefs.setBool("serviceProviderLoggedIn", true);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ServiceProviderHomePage()));
        }
      });
    }
  }

  @override
  void dispose() {
    serviceProviderEmailTextEditingController.dispose();
    serviceProviderNameTextEditingController.dispose();
    serviceProviderPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Material(
      child: Form(
        key: _formKey,
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
              height: height * .05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: serviceProviderNameTextEditingController,
                decoration: InputDecoration(
                    hintText: "Username", hintStyle: TextStyles.buttonTextDark),
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
                controller: serviceProviderEmailTextEditingController,
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
                decoration: InputDecoration(
                    hintText: "Password", hintStyle: TextStyles.buttonTextDark),
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
              height: height * .02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: serviceProviderPasswordTextEditingController,
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
                    chipName: skill[0].name,
                    isSelected: _isSelected0,
                    toggleChipState: (bool isSelectedValue) {
                      setState(() {
                        _isSelected0 = isSelectedValue;
                      });
                    },
                  ),
                  FilterChipWidget(
                    chipName: skill[1].name,
                    isSelected: _isSelected1,
                    toggleChipState: (isSelectedValue) {
                      setState(() {
                        _isSelected1 = isSelectedValue;
                      });
                    },
                  ),
                  FilterChipWidget(
                    chipName: skill[2].name,
                    isSelected: _isSelected2,
                    toggleChipState: (isSelectedValue) {
                      setState(() {
                        _isSelected2 = isSelectedValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * .02,
            ),
            DropDownButtonWidgetCountry(
              valueChoose: countrySelected,
              toggleValueChoose: (countrySelectedState) {
                setState(() {
                  countrySelected = countrySelectedState;
                });
              },
            ),
            SizedBox(
              height: height * .02,
            ),
            DropDownButtonWidgetCity(
                valueChoose: citySelected,
                toggleValueChoose: (citySelectedState) {
                  setState(() {
                    citySelected = citySelectedState;
                  });
                }),
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
                                  ..onTap = () => showTermsAndConditionsBox(context)),
                          ])),
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
            InkWell(
              onTap: () {
                print("Country " + countrySelected);
                print("City " + citySelected);
              },
              child: AppButton(
                buttonText: "Paypal",
                buttonType: ButtonType.paypalButton,
              ),
            ),
            SizedBox(
              height: height * .01,
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
                      buttonType: ButtonType.disableButton,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
