import 'package:ehire_app/scr/screens/userScreens/userChatScreen.dart';
import 'package:ehire_app/scr/services/userDatabase.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:ehire_app/scr/utils/sharedprefer_helper.dart';
import 'package:ehire_app/scr/widgets/AppButton.dart';
import 'package:ehire_app/scr/widgets/filterChipWidget.dart';
import 'package:flutter/material.dart';

class ServiceProviderDetailScreen extends StatefulWidget {
  final String serviceProviderName;
  final String about;
  final String serviceProviderId;
  final String profilePic;
  final List skills;

  const ServiceProviderDetailScreen(
      {Key key,
      this.serviceProviderName,
      this.about,
      this.serviceProviderId,
      this.profilePic,
      this.skills})
      : super(key: key);

  @override
  _ServiceProviderDetailScreenState createState() =>
      _ServiceProviderDetailScreenState();
}

class _ServiceProviderDetailScreenState
    extends State<ServiceProviderDetailScreen> {
  String myId, myUserName;
  getMyInfoFromSharedPreference() async {
    myId = await SharedPreferenceHelper.getUserId();
    myUserName = await SharedPreferenceHelper.getUserName();
  }

  getChatRoomIdbyBothUserIds(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    getMyInfoFromSharedPreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenBlue,
        elevation: 0.0,
      ),
      backgroundColor: AppColors.greenBlue,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * .03,
            ),
            Center(
              child: CircleAvatar(
                maxRadius: 100.0,
                backgroundColor: AppColors.white,
                backgroundImage: widget.profilePic == null
                    ? AssetImage("assets/images/user.png")
                    : NetworkImage(widget.profilePic),
              ),
            ),
            SizedBox(
              height: height * .01,
            ),
            Center(
              child: Text(
                widget.serviceProviderName.toString(),
                style: TextStyles.buttonTextLight,
              ),
            ),
            SizedBox(
              height: height * .05,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "About:",
                    style: TextStyles.buttonTextLight,
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * .01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  widget.about.toString(),
                  style: TextStyles.buttonTextLight,
                  maxLines: 3,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            SizedBox(
              height: height * .03,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Skills:",
                    style: TextStyles.buttonTextLight,
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * .01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Wrap(
                spacing: 10.0,
                runSpacing: 0.0,
                children: [
                  FilterChipWidget(
                    chipName: widget.skills[0],
                    isSelected: false,
                  ),
                  FilterChipWidget(
                    chipName: widget.skills[1],
                    isSelected: false,
                  ),
                  FilterChipWidget(
                    chipName: widget.skills[2],
                    isSelected: false,
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * .01,
            ),
            InkWell(
              onTap: () {
                var chatRoomId =
                    getChatRoomIdbyBothUserIds(myId, widget.serviceProviderId);
                Map<String, dynamic> chatRoomInfoMap = {
                  "usersids": [myId, widget.serviceProviderId],
                };
                DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserChatScreen(
                              name: widget.serviceProviderName,
                              chatWithUserNameID: widget.serviceProviderId,
                              myId: myId,
                              myUserName: myUserName,
                            )));
              },
              child: AppButton(
                buttonText: "Chat Now",
                buttonType: ButtonType.brownblack,
              ),
            )
          ],
        ),
      ),
    );
  }
}
