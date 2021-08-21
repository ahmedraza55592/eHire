import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehire_app/scr/screens/userScreens/userChatScreen.dart';
import 'package:ehire_app/scr/services/userDatabase.dart';
import 'package:ehire_app/scr/styles/baseStyle.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:ehire_app/scr/utils/sharedprefer_helper.dart';
import 'package:flutter/material.dart';

class ChatRoomListTile extends StatefulWidget {
  final String lastMessage, chatRoomId, myId;

  const ChatRoomListTile(
      {Key key, this.lastMessage, this.chatRoomId, this.myId})
      : super(key: key);
  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String username = "", userId = "", profilePic;
  String serviceProviderId, serviceProviderName;

  getChatRoomIdbyBothUserIds(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  getThisUserInfo() async {
    userId = widget.chatRoomId.replaceAll(widget.myId, "").replaceAll("_", "");
    // userId = widget.chatRoomId.replaceAll("_", "");
    print("The user Id is " + userId);

    QuerySnapshot querySnapshot =
        await DatabaseMethods().getUserInfobyId(userId);

    username = "${querySnapshot.docs[0]["userName"]}";
    profilePic = "${querySnapshot.docs[0]["profilePic"]}";

    print("Printing the username of User " + username);

    serviceProviderId = await SharedPreferenceHelper.getServiceProviderId();
    print("Printing the service Provider Id " + serviceProviderId);

    serviceProviderName = await SharedPreferenceHelper.getServiceProviderName();
    print("Printing the service Provider Id " + serviceProviderName);

//

    // QuerySnapshot querySnapshot =
    // await DatabaseMethods().getServiceProviderInfobyId(userId);
//
    // print("Printing the querySnapShot id " + querySnapshot.docs[0].id);
    // serviceProviderName = "${querySnapshot.docs[0]["serviceProviderName"]}";
    // print(serviceProviderName);
    // print("Getting the userName snapshot " +
    // querySnapshot.docs[0].data()['serviceProviderName']);
    setState(() {});
  }

  @override
  void initState() {
    getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var chatRoomId = getChatRoomIdbyBothUserIds(serviceProviderId, userId);
        Map<String, dynamic> chatRoomInfoMap = {
          "usersids": [serviceProviderId, userId],
        };
        DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserChatScreen(
                      chatWithUserNameID: userId,
                      name: username,
                      myId: serviceProviderId,
                      myUserName: serviceProviderName,
                      //  username, name
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: BaseStyles.boxShadowofChat,
            color: AppColors.white,
            borderRadius: BorderRadius.circular(BaseStyles.borderRadius - 10)),
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10.0),
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        child: Row(
          children: [
            // SizedBox(
            // width: 5,
            // ),

            CircleAvatar(
              maxRadius: 25.0,
              backgroundImage: profilePic == null
                  ? AssetImage("assets/images/user.png")
                  : NetworkImage(profilePic),
            ),
            // ClipRRect(
            // borderRadius: BorderRadius.circular(10),
            // child: Image.network(
            // (profilePic),
            // color: AppColors.black,
            // height: 40,
            // width: 40,
            // ),
            // ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyles.buttonTextDark,
                ),
                // SizedBox(height: 3),
                // Text(
                //   "Hello",
                //   style: TextStyles.buttonTextDarkSmall,
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}
