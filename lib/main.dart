import 'package:ehire_app/scr/app.dart';
import 'package:ehire_app/scr/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(App());
}
