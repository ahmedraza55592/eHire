import 'dart:convert';

import 'package:ehire_app/scr/utils/constants.dart';

class SharedPreferenceHelper {
  //Keys for User
  static String userIdKey = "USERIDKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userProfilePicKey = "USERPROFILEPICKEY";
  static String userAddressKey = 'USERADDRESS';
  static String userAboutKey = 'USERABOUT';

  //Keys for ServiceProvicer

  static String serviceProviderIdKey = "SERVICEPROVIDERIDKEY";
  static String serviceProviderNameKey = "SERVICEPROVIDERNAMEKEY";
  static String serviceProviderEmailKey = "SERVICEPROVIDEREMAILKEY";
  static String serviceProviderProfilePicKey = "SERVICEPROVIDERPROFILEPICKEY";
  static String serviceProviderAddressKey = 'SERVICEPROVIDERADDRESS';
  static String serviceProviderAboutKey = 'SERVICEPROVIDERABOUT';
  static String serviceProviderSkillKey = "SERVICEPROVIDERSKILLSKEY";

  // Save the User Data to Shared Preferences

  static Future<bool> saveUserID(String getUserId) async {
    return Constants.prefs.setString(userIdKey, getUserId);
  }

  static Future<bool> saveUserName(String getUserName) async {
    return Constants.prefs.setString(userNameKey, getUserName);
  }

  static Future<bool> saveUserEmail(String getUseremail) async {
    return Constants.prefs.setString(userEmailKey, getUseremail);
  }

  static Future<bool> saveProfilePic(String getUserProfile) async {
    return Constants.prefs.setString(userProfilePicKey, getUserProfile);
  }

  static Future<bool> saveUserAddress(String getUserAddress) async {
    return Constants.prefs.setString(userAddressKey, getUserAddress);
  }

  static Future<bool> saveUserAbout(String getUserAbout) async {
    return Constants.prefs.setString(userAboutKey, getUserAbout);
  }

  // Save the Service Provider Data to Shared Preferences

  static Future<bool> saveServiceProviderID(String getServiceProviderId) async {
    return Constants.prefs
        .setString(serviceProviderIdKey, getServiceProviderId);
  }

  static Future<bool> saveServiceProviderName(
      String getServiceProviderName) async {
    return Constants.prefs
        .setString(serviceProviderNameKey, getServiceProviderName);
  }

  static Future<bool> saveServiceProviderEmail(
      String getServiceProvideremail) async {
    return Constants.prefs
        .setString(serviceProviderEmailKey, getServiceProvideremail);
  }

  static Future<bool> saveServiceProviderProfilePic(
      String getServiceProviderProfile) async {
    return Constants.prefs
        .setString(serviceProviderProfilePicKey, getServiceProviderProfile);
  }

  static Future<bool> saveServiceProviderAddress(
      String getServiceProviderAddress) async {
    return Constants.prefs
        .setString(serviceProviderAddressKey, getServiceProviderAddress);
  }

  static Future<bool> saveServiceProviderAbout(
      String getServiceProviderAbout) async {
    return Constants.prefs
        .setString(serviceProviderAboutKey, getServiceProviderAbout);
  }

  static Future<bool> saveServiceProviderSkill(
      String getServiceProviderSkill) async {
    return Constants.prefs
        .setString(serviceProviderSkillKey, json.encode(getServiceProviderSkill));
  }

  // Get the User Data from Shared Preferences

  static Future<String> getUserId() async {
    return Constants.prefs.getString(userIdKey);
  }

  static Future<String> getUserName() async {
    return Constants.prefs.getString(userNameKey);
  }

  static Future<String> getUserEmail() async {
    return Constants.prefs.getString(userEmailKey);
  }

  static Future<String> getUserProfilePic() async {
    return Constants.prefs.getString(userProfilePicKey);
  }

  static Future<String> getUserAddress() async {
    return Constants.prefs.getString(userAddressKey);
  }

  static Future<String> getUserAbout() async {
    return Constants.prefs.getString(userAboutKey);
  }

  // Get the ServiceProvider Data from Shared Preferences

  static Future<String> getServiceProviderId() async {
    return Constants.prefs.getString(serviceProviderIdKey);
  }

  static Future<String> getServiceProviderName() async {
    return Constants.prefs.getString(serviceProviderNameKey);
  }

  static Future<String> getServiceProviderEmail() async {
    return Constants.prefs.getString(serviceProviderEmailKey);
  }

  static Future<String> getServiceProviderProfilePic() async {
    return Constants.prefs.getString(serviceProviderProfilePicKey);
  }

  static Future<String> getServiceProviderAddress() async {
    return Constants.prefs.getString(serviceProviderAddressKey);
  }

  static Future<String> getServiceProviderAbout() async {
    return Constants.prefs.getString(serviceProviderAboutKey);
  }

  static Future<String> getServiceProviderSkill() async {
    return json.decode(Constants.prefs.getString(serviceProviderSkillKey));
  }
}
