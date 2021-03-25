import 'package:flutter/material.dart';
import 'package:neighbourly/UserScreens/addIssue.dart';
import 'package:neighbourly/getStarted.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:neighbourly/loginDetails.dart';
import 'package:neighbourly/signupDetails.dart';

import 'dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
        child: MaterialApp(
          theme: ThemeData.dark(),
          initialRoute: '/getStarted',
          routes: {
            '/getStarted':(context)=>GetStarted(),
            '/loginDetails':(context)=>LoginDetails(),
            '/signupDetails':(context)=>SignupDetails(),
            '/dashboard':(context)=>Dashboard(),
            '/addIssue':(context)=>AddIssue()
          },
        )
    );
  }
}


