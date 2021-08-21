import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehire_app/scr/services/userDatabase.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/utils/sharedprefer_helper.dart';
import 'package:ehire_app/scr/widgets/chatRoomListTile.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

class ServiceProviderHomePage extends StatefulWidget {
  @override
  _ServiceProviderHomePageState createState() =>
      _ServiceProviderHomePageState();
}

class _ServiceProviderHomePageState extends State<ServiceProviderHomePage> {
  String serviceProviderId, serviceProviderName, serviceProviderProfilePic;
  Stream chatRoomStream;

  getMyInfoFromSharedPreference() async {
    serviceProviderId = await SharedPreferenceHelper.getServiceProviderId();
    serviceProviderName = await SharedPreferenceHelper.getServiceProviderName();
    serviceProviderProfilePic =
        await SharedPreferenceHelper.getServiceProviderProfilePic();
    setState(() {});
  }

  Widget chatRoomList() {
    return StreamBuilder(
        stream: chatRoomStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentsnapshot =
                        snapshot.data.docs[index];
                    return ChatRoomListTile(
                      // lastMessage: documentsnapshot["lastMessage"],
                      chatRoomId: documentsnapshot.id,
                      myId: serviceProviderId,
                      // documentsnapshot["lastMessage"], documentsnapshot.id, serviceProviderId,
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  getChatRooms() async {
    chatRoomStream = await DatabaseMethods().getChatRooms();
    setState(() {});
  }

  onServiceProviderPageLoaded() async {
    await getMyInfoFromSharedPreference();
    getChatRooms();
  }

  @override
  void initState() {
    onServiceProviderPageLoaded();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: GestureDetector(
              onTap: () {
                print("Something ");
                Navigator.pushReplacementNamed(
                    context, MyRoutes.serviceProviderUpdateProfile);
              },
              child: CircleAvatar(
                backgroundColor: AppColors.greenBlue,
                backgroundImage: serviceProviderProfilePic == null
                    ? AssetImage("assets/images/user.png")
                    : NetworkImage(serviceProviderProfilePic),
              ),
            ),
          )),
      body: ListView(
        padding: EdgeInsets.all(0.0),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // IconButton(
                //   icon: Icon(
                //     Icons.account_circle_rounded,
                //     size: 40.0,
                //   ),
                //   onPressed: () {
                //     print("serviceProvider ID" + serviceProviderId.toString());
                //     Navigator.pushReplacementNamed(
                //         context, MyRoutes.serviceProviderUpdateProfile);
                //     // Navigator.pushReplacement(
                //     //     context,
                //     //     MaterialPageRoute(
                //     //         builder: (context) => ServiceProviderUpdateProfile(
                //     //               uid: serviceProviderId,
                //     //             )));
                //   },
                // ),
              ],
            ),
          ),
          chatRoomList(),
        ],
      ),
    );
  }
}
