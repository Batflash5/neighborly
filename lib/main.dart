import 'package:flutter/material.dart';
import 'package:neighbourly/UserScreens/addIssue.dart';
import 'package:neighbourly/UserScreens/myposts.dart';
import 'package:neighbourly/getStarted.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:neighbourly/loginDetails.dart';
import 'package:neighbourly/signupDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  String email = sp.get('email');
  runApp(MyApp(
    email: email,
  ));
}

class MyApp extends StatelessWidget {
  final email;
  MyApp({this.email});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
        child: MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: email == null ? '/getStarted' : '/dashboard',
      // initialRoute:'/currentLocation',
      routes: {
        '/getStarted': (context) => GetStarted(),
        '/loginDetails': (context) => LoginDetails(),
        '/signupDetails': (context) => SignupDetails(),
        '/dashboard': (context) => Dashboard(),
        '/addIssue': (context) => AddIssue(),
        '/mypost': (context) => Myposts(),
        // '/currentLocation':(context)=>CurrentLocation()
      },
    ));
  }
}
