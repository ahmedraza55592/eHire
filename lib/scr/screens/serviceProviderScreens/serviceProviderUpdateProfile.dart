import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehire_app/scr/models/skills.dart';
import 'package:ehire_app/scr/routes.dart';
import 'package:ehire_app/scr/services/userDatabase.dart';
import 'package:ehire_app/scr/services/userFirestoreservice.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:ehire_app/scr/utils/constants.dart';
import 'package:ehire_app/scr/utils/sharedprefer_helper.dart';
import 'package:ehire_app/scr/widgets/AppButton.dart';
import 'package:ehire_app/scr/widgets/dropDownButtonCity.dart';
import 'package:ehire_app/scr/widgets/dropDownButtonCountry.dart';
import 'package:ehire_app/scr/widgets/filterChipWidget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ServiceProviderUpdateProfile extends StatefulWidget {
  @override
  _ServiceProviderUpdateProfileState createState() =>
      _ServiceProviderUpdateProfileState();
}

class _ServiceProviderUpdateProfileState
    extends State<ServiceProviderUpdateProfile> {
  TextEditingController serviceProviderAboutTextEditingController =
      TextEditingController();
  TextEditingController serviceProviderUserNameTextEditingController =
      TextEditingController();
  TextEditingController serviceProviderAddressTextEditingController =
      TextEditingController();

  DatabaseMethods databaseMethods = DatabaseMethods();

  List<Skill> skill = [
    Skill(name: "Gardener"),
    Skill(name: "House Cleaner"),
    Skill(name: "Drain Pipe Cleaner"),
  ];

  bool _isSelected0 = false, _isSelected1 = false, _isSelected2 = false;

  String myId, myUserName, about, address, profilePic, email;
  getMyInfoFromSharedPreference() async {
    myId = await SharedPreferenceHelper.getServiceProviderId();
    myUserName = await SharedPreferenceHelper.getServiceProviderName();
    about = await SharedPreferenceHelper.getServiceProviderAbout();
    address = await SharedPreferenceHelper.getServiceProviderAddress();
    profilePic = await SharedPreferenceHelper.getServiceProviderProfilePic();
    email = await SharedPreferenceHelper.getServiceProviderEmail();
    // List sskills = await SharedPreferenceHelper.getServiceProviderSkill();
    setState(() {});
  }

  onUpdateProfilePageLoaded() async {
    await getMyInfoFromSharedPreference();
  }

  File _image;
  String profilePicLink;
  Future getImage() async {
    final _picker = ImagePicker();
    var image = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (PickedFile != null) {
        _image = File(image.path);
      } else {
        print("NO Image Selected");
      }
      // _image = File(image.path);
    });
  }

  @override
  void initState() {
    onUpdateProfilePageLoaded();
    super.initState();
  }

  update() async {
    try {
      Reference ref = FirebaseStorage.instance.ref();
      TaskSnapshot addImg = await ref.child("image/$myId").putFile(_image);
      if (addImg.state == TaskState.success) {
        String link = await addImg.ref.getDownloadURL();
        setState(() {
          profilePicLink = link;
        });
      }
    } catch (e) {
      print("No picture is Selected " + e.toString());
    }

    // print("Getting the id of user before updating data " + myId);
    Map<String, dynamic> sericeProviderDataMap = {
      "serviceProviderName":
          serviceProviderUserNameTextEditingController.text == ""
              ? myUserName
              : serviceProviderUserNameTextEditingController.text,
      "address": serviceProviderAddressTextEditingController.text == ""
          ? address
          : serviceProviderAddressTextEditingController.text,
      "about": serviceProviderAboutTextEditingController.text == ""
          ? about
          : serviceProviderAboutTextEditingController,
      "serviceProviderProfilePic": profilePicLink ?? profilePic,
      "skill": [
        _isSelected0 == true ? skill[0].name : "",
        _isSelected1 == true ? skill[1].name : "",
        _isSelected2 == true ? skill[2].name : "",
      ],
    };

    print("isSelected 0 value " + _isSelected0.toString());
    print("isSelected 1 value " + _isSelected1.toString());
    print("isSelected 2 value " + _isSelected2.toString());

    // print("Getting the id of user after updating data " + myId);

    await databaseMethods.updataServiceProvicerInfoToDB(
        myId, sericeProviderDataMap);

    QuerySnapshot serviceProviderInfoSnapshot =
        await DatabaseMethods().getServiceProviderInfo(email);

    SharedPreferenceHelper.saveServiceProviderEmail(
        serviceProviderInfoSnapshot.docs[0].data()['serviceProviderEmail']);

    SharedPreferenceHelper.saveServiceProviderName(
        serviceProviderInfoSnapshot.docs[0].data()['serviceProviderName']);

    SharedPreferenceHelper.saveServiceProviderID(
        serviceProviderInfoSnapshot.docs[0].data()['serviceProviderId']);

    SharedPreferenceHelper.saveServiceProviderAbout(
        serviceProviderInfoSnapshot.docs[0].data()['about']);

    SharedPreferenceHelper.saveServiceProviderAddress(
        serviceProviderInfoSnapshot.docs[0].data()['address']);

    SharedPreferenceHelper.saveServiceProviderProfilePic(
        serviceProviderInfoSnapshot.docs[0]
            .data()['serviceProviderProfilePic']);

    // SharedPreferenceHelper.serviceProviderSkillKey(
    //     serviceProviderInfoSnapshot.docs[0]
    //         .data()['skill'][0]);

    Navigator.pushReplacementNamed(context, MyRoutes.serviceProviderHomePage);

    // Navigator.pushReplacement(
    // context,
    // MaterialPageRoute(
    // builder: (context) => ServiceProviderHomePage(uid: widget.uid)));
  }

  @override
  void dispose() {
    serviceProviderAboutTextEditingController.dispose();
    serviceProviderAddressTextEditingController.dispose();
    serviceProviderUserNameTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: GestureDetector(
              onTap: () {
                print("Something ");
                print("isSelected 0 value " + _isSelected0.toString());
                print("isSelected 1 value " + _isSelected1.toString());
                print("isSelected 2 value " + _isSelected2.toString());
                Navigator.pushReplacementNamed(
                    context, MyRoutes.serviceProviderHomePage);
              },
              child: CircleAvatar(
                backgroundColor: AppColors.greenBlue,
                backgroundImage: profilePic == null
                    ? AssetImage("assets/images/user.png")
                    : NetworkImage(profilePic),
              ),
            ),
          )

          // leading: IconButton(
          //   color: AppColors.black,
          //   icon: profilePic == null
          //       ? Icon(
          //           Icons.account_circle_rounded,
          //           size: 40.0,
          //         )
          //       : NetworkImage(profilePic),
          //   onPressed: () {
          //     print("Check the about name before updating " + about);

          //     print("Profile Pic " + profilePic.toString());

          //     print("Check the user Id at Update Page" + myId);

          //     print("Checking the about name after updating " + about);

          //     // Navigator.pushReplacement(
          //     //     context,
          //     //     MaterialPageRoute(
          //     //         builder: (context) => UserHomePage()));
          //     //
          //     Navigator.pushReplacementNamed(context, MyRoutes.userHomePage);

          //     // Navigator.pop(context);

          //     // Navigator.pushReplacement(
          //     //     context,
          //     //     MaterialPageRoute(
          //     //         builder: (context) => UserHomePage(
          //     //               uid: widget.uid,
          //     //             )));

          //     // Navigator.pop(context);
          //   },
          // ),
          ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * .015,
            ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       Icons.account_circle_rounded,
//                       size: 40.0,
//                     ),
//                     onPressed: () {
//                       print(
//                           "Check the servide Provider user Id at Update Page" +
//                               myId);

//                       Navigator.pushReplacementNamed(
//                           context, MyRoutes.serviceProviderHomePage);
//                       // Navigator.pushReplacement(
//                       // context,
//                       // MaterialPageRoute(
//                       // builder: (context) => ServiceProviderHomePage(
//                       // uid: widget.uid,
//                       // )));
// //
//                       // Navigator.pushReplacement
//                       // context, MaterialPageRoute(builder: (context) => ServiceProviderHomePage()));
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(
//               height: height * .015,
//             ),
            Center(
              child: IconButton(
                iconSize: height * .2,
                alignment: Alignment.center,
                icon: profilePic == null && _image == null
                    ? Icon(
                        Icons.account_circle_rounded,
                      )
                    : CircleAvatar(
                        maxRadius: height * .2,
                        backgroundImage: profilePic != null
                            ? NetworkImage(profilePic)
                            : FileImage(_image)
                        // child: Image.file(_image)
                        ),
                onPressed: () {
                  getImage();
                },
              ),
            ),
            SizedBox(
              height: height * .01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: serviceProviderUserNameTextEditingController,
                decoration: InputDecoration(
                    hintText: "Username: " + myUserName.toString(),
                    hintStyle: TextStyles.buttonTextDark),
              ),
            ),
            SizedBox(
              height: height * .02,
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Wrap(
                spacing: 10.0,
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

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //   child: Wrap(
            //     spacing: 15.0,
            //     runSpacing: 2.0,
            //     children: [
            //       FilterChipWidget(
            //         chipName: "Gardener",
            //       ),
            //       FilterChipWidget(
            //         chipName: "House Cleaner",
            //       ),
            //       FilterChipWidget(
            //         chipName: "Drain Pipe Cleaner",
            //       )
            //     ],
            //   ),
            // ),
            SizedBox(
              height: height * .02,
            ),
            DropDownButtonWidgetCountry(),
            SizedBox(
              height: height * .02,
            ),
            DropDownButtonWidgetCity(),
            SizedBox(
              height: height * .02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: serviceProviderAddressTextEditingController,
                decoration: InputDecoration(
                    hintText: "Address: " + address.toString(),
                    hintStyle: TextStyles.buttonTextDark),
              ),
            ),
            SizedBox(
              height: height * .01,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                maxLines: 4,
                controller: serviceProviderAboutTextEditingController,
                decoration: InputDecoration(
                    hintText: "About: " + about.toString(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () {
                      update();
                    },
                    child: AppButton(
                      buttonText: "Update",
                      buttonType: ButtonType.brownblack,
                    ),
                  ),
                ),
                Container(
                  height: 50.0,
                  width: 2.0,
                  color: AppColors.black,
                ),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      Constants.prefs.setBool("userLoggedIn", false);
                      AuthMethods().signOut().then((s) {
                        Navigator.pushReplacementNamed(
                            context, MyRoutes.serviceProviderLoginpage);
                      });
                    },
                    child: AppButton(
                      buttonText: "Log out",
                      buttonType: ButtonType.brownblack,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * .04,
            ),
          ],
        ),
      ),
    );
  }
}
