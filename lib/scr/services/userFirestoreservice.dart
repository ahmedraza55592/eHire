// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ehire_app/scr/models/usersModel.dart';

// class FireStoreUserService {
//   FirebaseFirestore _db = FirebaseFirestore.instance;

//   Future<void> addUser(Users user) {
//     return _db.collection("users").doc(user.userId).set(user.toMap());
//   }

//   Future<Users> fetchUser(String userId) {
//     return _db
//         .collection('users')
//         .doc(userId)
//         .get()
//         .then((snapshot) => Users.fromFirestore(snapshot.data()));
//   }
// }
//

import 'package:ehire_app/scr/models/usersModel.dart';
import 'package:ehire_app/scr/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return auth.currentUser;
  }

  UserClass _userFromFirebaseUser(User user) {
    return user != null ? UserClass(uid: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      var result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      var result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPass(String email) async {
    try {
      return await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    Constants.prefs.clear();
    await auth.signOut();
  }

  //  Future signOut() async {
  //   try {
  //     return await auth.signOut();
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
}
