import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehire_app/scr/routes.dart';
import 'package:ehire_app/scr/services/userDatabase.dart';
import 'package:ehire_app/scr/services/userFirestoreservice.dart';
import 'package:ehire_app/scr/styles/baseStyle.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:ehire_app/scr/utils/constants.dart';
import 'package:ehire_app/scr/utils/sharedprefer_helper.dart';
import 'package:ehire_app/scr/widgets/AppButton.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserUpdateProfile extends StatefulWidget {
  @override
  _UserUpdateProfileState createState() => _UserUpdateProfileState();
}

class _UserUpdateProfileState extends State<UserUpdateProfile> {
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController userEmailUpdateTextEditingController =
      TextEditingController();
  TextEditingController userAddressTextEditingController =
      TextEditingController();
  TextEditingController userAboutTextEditingController =
      TextEditingController();

  DatabaseMethods databaseMethods = DatabaseMethods();

  File _image;
  String profilePicLink;

  // Future getImage() async {
  //   final pickedFile = await imagepicker.getImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print("No image Selected");
  //     }
  //   });
  // }

  Future getImage() async {
    final _picker = ImagePicker();
    var image = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (PickedFile != null) {
        _image = File(image.path);
      } else {
        print("NO Image Selected");
      }
    });
  }

  String myId, myUserName, about, address, email, profilePic;
  getMyInfoFromSharedPreference() async {
    myId = await SharedPreferenceHelper.getUserId();
    myUserName = await SharedPreferenceHelper.getUserName();
    about = await SharedPreferenceHelper.getUserAbout();
    address = await SharedPreferenceHelper.getUserAddress();
    email = await SharedPreferenceHelper.getUserEmail();
    profilePic = await SharedPreferenceHelper.getUserProfilePic();
    setState(() {});
  }

  onUpdateProfilePageLoaded() async {
    await getMyInfoFromSharedPreference();
  }

  @override
  void initState() {
    onUpdateProfilePageLoaded();
    super.initState();
  }

  update() async {
    Reference ref = FirebaseStorage.instance.ref();
    TaskSnapshot addImg = await ref.child("image/$_image").putFile(_image);
    if (addImg.state == TaskState.success) {
      String link = await addImg.ref.getDownloadURL();
      setState(() {
        profilePicLink = link;
      });
    }
    // print("Getting the id of user before updating data " + widget.uid);
    Map<String, dynamic> userDataMap = {
      "userName": userNameTextEditingController.text == ""
          ? myUserName
          : userNameTextEditingController.text,
      "address": userAddressTextEditingController.text == ""
          ? address
          : userAddressTextEditingController.text,
      "about": userAboutTextEditingController.text == ""
          ? about
          : userAboutTextEditingController.text,
      "profilePic": profilePicLink,
    };

    // print("Getting the id of user after updating data " + widget.uid);

    await databaseMethods.updataUserInfoToDB(myId, userDataMap);

    QuerySnapshot userInfoSnapshot = await DatabaseMethods().getUserInfo(email);

    SharedPreferenceHelper.saveUserName(
        userInfoSnapshot.docs[0].data()['userName']);

    SharedPreferenceHelper.saveUserAbout(
        userInfoSnapshot.docs[0].data()['about']);

    SharedPreferenceHelper.saveUserAddress(
        userInfoSnapshot.docs[0].data()['address']);

    SharedPreferenceHelper.saveProfilePic(
        userInfoSnapshot.docs[0].data()['profilePic']);

    // Constants.prefs.reload();

    Navigator.pushReplacementNamed(context, MyRoutes.userHomePage);

    // Navigator.pushReplacement(
    // context, MaterialPageRoute(builder: (context) => UserHomePage()));
  }

  @override
  void dispose() {
    userNameTextEditingController.dispose();
    userAddressTextEditingController.dispose();
    userAboutTextEditingController.dispose();
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
                Navigator.pushReplacementNamed(context, MyRoutes.userHomePage);
              },
              child: CircleAvatar(
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
          children: [
            SizedBox(
              height: height * .015,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.filter_alt_sharp,
                  //     size: 40.0,
                  //   ),
                  //   onPressed: () {
                  //     showModalBottomSheet(
                  //         context: context,
                  //         isScrollControlled: true,
                  //         builder: (context) => UserFilterScreen());
                  //   },
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: height * .01,
            ),
            IconButton(
              iconSize: height * .2,
              alignment: Alignment.center,
              icon: _image == null
                  ? Icon(
                      Icons.account_circle_rounded,
                    )
                  : CircleAvatar(
                      maxRadius: height * .2,
                      backgroundImage: FileImage(_image),
                      // child: Image.file(_image)
                    ),
              onPressed: () {
                getImage();

                // FirebaseStorage fs = FirebaseStorage.instance;
                // TaskSnapshot snapshot =
                //     await fs.ref().child("pictures/image").putFile(_image);
                // if (snapshot.state == TaskState.success) {
                //   String link = await snapshot.ref.getDownloadURL();
                //   setState(() {
                //     profilePicLink = link;
                //   });
                // }
              },
            ),
            SizedBox(
              height: height * .01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: userNameTextEditingController,
                decoration: InputDecoration(
                    hintText: "UserName  " + myUserName.toString(),
                    hintStyle: TextStyles.buttonTextDark),
              ),
            ),
            SizedBox(
              height: height * .02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: userAddressTextEditingController,
                decoration: InputDecoration(
                    hintText: "Address " + address.toString(),
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
                controller: userAboutTextEditingController,
                decoration: InputDecoration(
                    hintText: "About " + about.toString(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            BaseStyles.borderRadius - 10.0))),
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
                  width: 1.0,
                  color: AppColors.black,
                ),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      Constants.prefs.setBool("userLoggedIn", false);
                      AuthMethods().signOut().then((s) {
                        Navigator.pushReplacementNamed(
                            context, MyRoutes.userLoginpage);
                      });
                    },
                    child: AppButton(
                      buttonText: "Log out",
                      buttonType: ButtonType.brownblack,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
