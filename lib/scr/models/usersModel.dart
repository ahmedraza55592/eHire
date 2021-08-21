// class Users {
//   final String userId;
//   final String email;
//   final String address;
//   final String userName;

//   Users({this.userId, this.email, this.address, this.userName});

//   Map<String, dynamic> toMap() {
//     return {
//       'userId': userId,
//       'email': email,
//       'phoneNo': address,
//       'userName': userName,
//     };
//   }

//   Users.fromFirestore(Map<String, dynamic> firestore)
//       : userId = firestore['userId'],
//         email = firestore['email'],
//         address = firestore['address'],
//         userName = firestore['userName'];
// }

class UserClass {
  final String uid;

  UserClass({this.uid});
  
}
