import 'package:ehire_app/scr/models/serviceProviderModel.dart';
import 'package:ehire_app/scr/routes.dart';
import 'package:ehire_app/scr/screens/userScreens/sericeProviderDetailScreen.dart';
import 'package:ehire_app/scr/services/userDatabase.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/utils/sharedprefer_helper.dart';
import 'package:ehire_app/scr/widgets/cardWidget.dart';
import 'package:ehire_app/scr/widgets/searchBarWidget.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  String myId, myUserName, profilePic;
  getMyInfoFromSharedPreference() async {
    myId = await SharedPreferenceHelper.getUserId();
    myUserName = await SharedPreferenceHelper.getUserName();
    profilePic = await SharedPreferenceHelper.getUserProfilePic();
    setState(() {});
  }

  onHomePageLoaded() async {
    await getMyInfoFromSharedPreference();
  }

  @override
  void initState() {
    onHomePageLoaded();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final DatabaseMethods _databaseMethods = DatabaseMethods();
  Stream<List<ServiceProviderModel>> get entries =>
      _databaseMethods.getEntries();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.white,
          leading: GestureDetector(
            onTap: () {
              print("Something ");
              Navigator.pushReplacementNamed(
                  context, MyRoutes.userUpdateProfile);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: CircleAvatar(
                backgroundImage: profilePic == null
                    ? AssetImage("assets/images/user.png")
                    : NetworkImage(profilePic),
              ),
            ),
          )
          // IconButton(
          // color: AppColors.black,
          // icon: profilePic == null
          // ? Icon(
          // Icons.account_circle_rounded,
          // size: 40.0,
          // )
          // : Image.network(profilePic),
          // onPressed: () {
          // print("Something ");
          // Navigator.pushReplacementNamed(context, MyRoutes.userUpdateProfile);
          // },
          // ),
          ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: height * .015,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 20.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       IconButton(
          //         icon: Icon(
          //           Icons.account_circle_rounded,
          //           size: 40.0,
          //         ),
          //         onPressed: () {
          //           // print("Checking the user id at Home page " + widget.uid);
          //           // print("Checking the user id at Home page of shared pref " +
          //           //     myId);

          //           Navigator.pushReplacementNamed(
          //               context, MyRoutes.userUpdateProfile);

          //           // Navigator.pushReplacement(
          //           // context,
          //           // MaterialPageRoute(
          //           // builder: (context) => UserUpdateProfile(
          //           // uid: widget.uid,
          //           // userName: widget.userName,
          //           // address: widget.address,
          //           // about: widget.about,
          //           // )));

          //           // Navigator.pushNamed(context, MyRoutes.userUpdateProfile,
          //           //     arguments: widget.uid);
          //         },
          //       ),
          //       // IconButton(
          //       //   icon: Icon(
          //       //     Icons.filter_alt_sharp,
          //       //     size: 40.0,
          //       //   ),
          //       //   onPressed: () {
          //       //     showModalBottomSheet(
          //       //         context: context,
          //       //         isScrollControlled: true,
          //       //         builder: (context) => UserFilterScreen());
          //       //   },
          //       // ),
          //     ],
          //   ),
          // ),
          SearchBarWidget(),
          SizedBox(
            height: height * .01,
          ),
          Expanded(
            child: StreamBuilder<List<ServiceProviderModel>>(
                stream: entries,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ServiceProviderDetailScreen(
                                          serviceProviderName: snapshot
                                              .data[index].serviceProviderName,
                                          about: snapshot.data[index].about,
                                          serviceProviderId: snapshot
                                              .data[index].serviceProviderId,
                                          profilePic: snapshot.data[index]
                                              .serviceProviderProfilePic,
                                          skills: snapshot.data[index].skills,
                                        )));
                          },
                          child: CardWidget(
                            serviceProviderName:
                                snapshot.data[index].serviceProviderName,
                            city: snapshot.data[index].city,
                            profilePic:
                                snapshot.data[index].serviceProviderProfilePic,
                            skills: snapshot.data[index].skills,
                            // skill:
                            // userName: snapshot.data[index].,
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          // Expanded(
          //   child: StreamBuilder<List<ServiceProviderModel>>(
          //       stream: entries,
          //       builder: (context, snapshot) {
          //         if (snapshot.hasData) {
          //           return ListView.builder(
          //             itemCount: snapshot.data.length,
          //             scrollDirection: Axis.horizontal,
          //             shrinkWrap: true,
          //             padding: EdgeInsets.all(20.0),
          //             itemBuilder: (context, index) {
          //               return InkWell(
          //                 onTap: () {
          //                   Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (context) =>
          //                               ServiceProviderDetailScreen(
          //                                 serviceProviderName: snapshot
          //                                     .data[index].serviceProviderName,
          //                                 about: snapshot.data[index].about,
          //                                 serviceProviderId: snapshot
          //                                     .data[index].serviceProviderId,
          //                               )));
          //                 },
          //                 child: CardWidget(
          //                   serviceProviderName:
          //                       snapshot.data[index].serviceProviderName,
          //                   city: snapshot.data[index].city,
          //                   // userName: snapshot.data[index].,
          //                 ),
          //               );
          //             },
          //           );
          //         }
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }),
          // ),
          // Divider(
          //   indent: 40.0,
          //   thickness: 2.0,
          //   endIndent: 40.0,
          // ),
          // SizedBox(
          //   height: height * .015,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Text(
          //         "Drain Cleaners: ",
          //         style: TextStyles.buttonTextDark,
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: height * .02,
          // ),
          // Expanded(
          //     child: ListView(
          //   scrollDirection: Axis.horizontal,
          //   shrinkWrap: true,
          //   padding: EdgeInsets.zero,
          //   children: [
          //     CardWidget(),
          //     CardWidget(),
          //     CardWidget(),
          //     CardWidget(),
          //   ],
          // )),
          // Divider(
          //   indent: 40.0,
          //   thickness: 2.0,
          //   endIndent: 40.0,
          // ),
          // SizedBox(
          //   height: height * .1,
          // ),
        ],
      ),
    );
  }
}
