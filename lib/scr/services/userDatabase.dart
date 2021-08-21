import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehire_app/scr/models/serviceProviderModel.dart';
import 'package:ehire_app/scr/utils/sharedprefer_helper.dart';

class DatabaseMethods {
  Future addUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  Future<QuerySnapshot> getUserInfo(String email) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .get();
  }

  Future updataUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update(userInfoMap);
  }

  Future addServiceProviderInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("serviceproviderusers")
        .doc(userId)
        .set(userInfoMap);
  }

  Future<QuerySnapshot> getServiceProviderInfo(String email) async {
    return await FirebaseFirestore.instance
        .collection("serviceproviderusers")
        .where("serviceProviderEmail", isEqualTo: email)
        .get();
  }

  Future updataServiceProvicerInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("serviceproviderusers")
        .doc(userId)
        .update(userInfoMap);
  }

  Future getServiceProviderInfoFromDB() async {
    return await FirebaseFirestore.instance
        .collection("serviceproviderusers")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {});
    });
  }

  Stream<List<ServiceProviderModel>> getEntries() {
    return FirebaseFirestore.instance
        .collection('serviceproviderusers')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ServiceProviderModel.fromFirestore(doc.data()))
            .toList());
  }

  Future addMessage(String chatRoomId, Map messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageInfoMap);

    // .doc(messageId)
    // .set(messageInfoMap);
  }

  createChatRoom(String chatRoomId, Map chatRoomInfoMap) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();

    if (snapshot.exists) {
      return true;
    } else {
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  // updatLastMessageSend(String chatRoomId, Map lastMessageInfoMap) {
  //   return FirebaseFirestore.instance
  //       .collection("chatrooms")
  //       .doc(chatRoomId)
  //       .update(lastMessageInfoMap);
  // }

  Future<Stream<QuerySnapshot>> getChatMessages(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("timeStamp", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms() async {
    String myUserId = await SharedPreferenceHelper.getServiceProviderId();
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .where("usersids", arrayContains: myUserId)
        .snapshots();
  }

  // Future<QuerySnapshot> getServiceProvideInfo(String serviceProviderId) async {
  //   return await FirebaseFirestore.instance
  //       .collection("users")
  //       .where("username", isEqualTo: )
  //       .get();
  // }
  Future<QuerySnapshot> getServiceProviderInfobyId(
      String serviceProviderId) async {
    return await FirebaseFirestore.instance
        .collection("serviceproviderusers")
        .where("serviceProviderId", isEqualTo: serviceProviderId)
        .get();
  }

  Future<QuerySnapshot> getUserInfobyId(String userId) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("userId", isEqualTo: userId)
        .get();
  }
}
