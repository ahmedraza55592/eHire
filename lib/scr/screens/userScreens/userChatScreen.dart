import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehire_app/scr/screens/userScreens/usersendLocation.dart';
import 'package:ehire_app/scr/services/userDatabase.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:ehire_app/scr/utils/sharedprefer_helper.dart';
import 'package:ehire_app/scr/widgets/dialogbox.dart';
import 'package:flutter/material.dart';

class UserChatScreen extends StatefulWidget {
  final String chatWithUserNameID, name, myId, myUserName;

  const UserChatScreen(
      {Key key, this.chatWithUserNameID, this.name, this.myId, this.myUserName})
      : super(key: key);

  @override
  _UserChatScreenState createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  TextEditingController messageTextEdittingController = TextEditingController();

  String chatRoomId;
  String myId, myUserName, serviceProvideruserName;
  Stream messageStream;
  getMyInfoFromSharedPreference() async {
    // myId = await SharedPreferenceHelper.getUserId();
    myUserName = await SharedPreferenceHelper.getUserName();
    // serviceProvideruserName = await SharedPreferenceHelper.getServiceProviderName();

    chatRoomId =
        getChatRoomIdbyBothUserIds(widget.chatWithUserNameID, widget.myId);
  }

  getChatRoomIdbyBothUserIds(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addMessage() {
    if (messageTextEdittingController.text.isNotEmpty) {
      String message = messageTextEdittingController.text;

      var lastMessaggeTimeStamp = DateTime.now();

      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": widget.myUserName,
        "timeStamp": lastMessaggeTimeStamp,
      };

      // Now we will generate a message Id
      // if (messageId == "") {
      //   messageId = randomAlphaNumeric(12);
      // }

      // Now upload the data that we saved in messageInfoMap

      DatabaseMethods().addMessage(chatRoomId, messageInfoMap);
      //   .then((value) {
      // Map<String, dynamic> lastMessageInfoMap = {
      //   "lastMessage": message,
      //   "lastMessageSendTimeStamp": lastMessaggeTimeStamp,
      //   "lastMessageSendBy": widget.myUserName,
      // };
      setState(() {
        messageTextEdittingController.text = "";
      });
    }
  }

  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: sendByMe ? Radius.circular(20) : Radius.circular(0),
                  bottomRight:
                      sendByMe ? Radius.circular(20) : Radius.circular(20),
                  topRight: sendByMe ? Radius.circular(0) : Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: sendByMe ? AppColors.greenBlue : Color(0xfff1f0f0),
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                message,
                style: sendByMe
                    ? TextStyles.buttonTextLightSmall
                    : TextStyles.buttonTextDarkSmall,
              )),
        ),
      ],
    );
  }

  Widget chatMessages() {
    return StreamBuilder(
        stream: messageStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  // shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 70.0, top: 10.0),
                  reverse: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return chatMessageTile(
                      ds["message"],
                      widget.myUserName == ds["sendBy"],
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  getAndSetMessages() async {
    messageStream = await DatabaseMethods().getChatMessages(chatRoomId);
    setState(() {});
  }

  onChatScreenLoaded() async {
    await getMyInfoFromSharedPreference();
    getAndSetMessages();
  }

  @override
  void initState() {
    onChatScreenLoaded();
    super.initState();
  }

  @override
  void dispose() {
    messageTextEdittingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.disableButtonColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.black),
        backgroundColor: AppColors.white,
        title: Text(
          widget.name.toString(),
          style: TextStyles.buttonTextDark,
        ),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Stack(
          children: [
            chatMessages(),
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
            ),
            Container(
              // margin: EdgeInsets.only(bottom: 20.0),
              // padding: EdgeInsets.only(bottom: 20.0),
              // alignment: Alignment.bottomCenter,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: AppColors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: messageTextEdittingController,
                        style: TextStyles.buttonTextDark,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message",
                            hintStyle: TextStyles.buttonTextDark),
                      )),
                      widget.myUserName == myUserName
                          ? InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => UserSendLocation());
                              },
                              child: Icon(
                                Icons.add_location,
                                color: AppColors.brownblack,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                print("Classic Idea to print invoice");

                                showDialogBox(context);
                              },
                              child: Icon(Icons.receipt_long)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .05,
                      ),
                      GestureDetector(
                        onTap: () {
                          addMessage();
                        },
                        child: Icon(
                          Icons.send,
                          color: AppColors.brownblack,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
