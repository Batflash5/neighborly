import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int _currentIndex=0;

  void onTabTapped(int index){
    setState(() {
      _currentIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded),label: 'Feed'),
            BottomNavigationBarItem(icon: Icon(Icons.post_add_sharp),label: 'File an Issue'),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
          ],
        ),
        body: Center(
          child: Text('Hello There'),
        ),
      ),
    );
  }
}
