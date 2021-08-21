import 'package:ehire_app/scr/styles/baseStyle.dart';
import 'package:ehire_app/scr/styles/colors.dart';
import 'package:ehire_app/scr/styles/textStyle.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String serviceProviderName;
  final String city;
  final String profilePic;
  final List skills;

  CardWidget(
      {this.city, this.serviceProviderName, this.profilePic, this.skills});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BaseStyles.borderRadius - 15)),
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      shadowColor: AppColors.greenBlue,
      color: AppColors.white,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ClipRRect(
          // borderRadius: BorderRadius.circular(30),
          // child: Image.asset(
          // "assets/images/user.png",
          // height: 50,
          // width: 50,
          // color: AppColors.greenBlue,
//
          // )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              // foregroundColor: AppColors.black,
              maxRadius: 30.0,
              backgroundColor: AppColors.white,
              backgroundImage: profilePic == null
                  ? AssetImage("assets/images/user.png")
                  : NetworkImage(profilePic),
            ),
          ),
          SizedBox(
            width: width * .01,
          ),
          Text(
            serviceProviderName,
            style: TextStyles.buttonTextDarkSmall,
          ),
          SizedBox(
            width: width * .01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$city | " + skills[0],
                style: TextStyles.buttonTextDarkSmall,
              ),
            ],
          ),
          // Row(
          //   children: [
          //     Text(
          //       "Skills: " + skills,
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
