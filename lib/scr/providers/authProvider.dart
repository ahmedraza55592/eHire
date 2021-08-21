// import 'package:ehire_app/scr/models/usersModel.dart';
// import 'package:ehire_app/scr/screens/userScreens/userHomepage.dart';
// import 'package:ehire_app/scr/services/userFirestoreservice.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:rxdart/rxdart.dart';

// import '../routes.dart';

// final _email = BehaviorSubject<String>();
//   final _address = BehaviorSubject<String>();
//   final _password = BehaviorSubject<String>();
//   final _userName = BehaviorSubject<String>();
//   final _user = BehaviorSubject<Users>();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FireStoreUserService _fireStoreUserService = FireStoreUserService();

//   //Get Data

//   //Set Data
//   Function(String) get changeEmail => _email.sink.add;
//   Function(String) get changePassword => _password.sink.add;
//   Function(String) get changeUserName => _userName.sink.add;
//   Function(String) get changePhoneNo => _address.sink.add;
//   // Stream<List<Users>> get entries =>
//   //     _fireStoreUserService.getEntries(_auth.currentUser.uid);

//   dispose() {
//     _email.close();
//     _password.close();
//     _address.close();
//     _userName.close();
//     _user.close();
//   }

//   //Functions

//   signupEmail(BuildContext context) async {
//     try {
//       var authResults = await _auth.createUserWithEmailAndPassword(
//           email: _email.value.trim(), password: _password.value.trim());
//       var user = Users(
//           userId: authResults.user.uid,
//           email: _email.value.trim(),
//           userName: _userName.value.trim(),
//           address: _address.value.trim());
//       await _fireStoreUserService.addUser(user);
//       _user.sink.add(user);

//       //The user will be loggedIn in the app if it exits the app when it will logout then when he enters then he will go to login page else homepage
//       // Constants.prefs.setBool("loggedIn", true);

//       // Get Success
//       Navigator.pushReplacementNamed(context, MyRoutes.userHomePage);
//     } on FirebaseAuthException catch (error) {
//       Fluttertoast.showToast(msg: error.message, gravity: ToastGravity.TOP);
//     }
//   }

//   signInEmail(BuildContext context) async {
//     try {
//       var authResult = await _auth.signInWithEmailAndPassword(
//           email: _email.value.trim(), password: _password.value.trim());
//       var user = await _fireStoreUserService.fetchUser(authResult.user.uid);
//       _user.sink.add(user);

//       // Set the key to true so that user can be logged in while exits and open the app again, when it open the app again it will go to homepage instead of login page
//       // Constants.prefs.setBool("loggedIn", true);
//       Navigator.of(context)
//           .pushReplacement(MaterialPageRoute(builder: (context) => UserHomePage()));
//     } on FirebaseAuthException catch (error) {
//       Fluttertoast.showToast(msg: error.message, gravity: ToastGravity.TOP);
//     }
//   }

//   // getUserInfo() async {
//   //   try {
//   //     var user = Users(
//   //       userName: _userName.value.trim(),
//   //     );
//   //     // var authResult = await _auth.signInWithEmailAndPassword(
//   //     //     email: _email.value.trim(), password: _password.value.trim());
//   //     await _fireStoreUserService.getUserName(user);
//   //     _user.sink.add(user);
//   //   } catch (error) {
//   //     print(error);
//   //   }
//   // }

// import 'package:ehire_app/scr/models/skills.dart';
// import 'package:flutter/foundation.dart';

// class SkillData extends ChangeNotifier {
//   List<Skill> skills = [
//     Skill(name: "Gardener"),
//     Skill(name: "Drain Cleaner"),
//     Skill(name: "Plumber"),
//   ];

// }
