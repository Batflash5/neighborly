import 'package:flutter/material.dart';
import 'package:neighbourly/UserScreens/addIssue.dart';
import 'UserScreens/feed.dart';

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

  Widget navigateTo(){
    switch(_currentIndex){
      case 0:{
        return Feed();
      }
      break;
      case 1:{
        return AddIssue();
      }
      default:{
        return Text('What!!!!!');
      }
      break;

    }
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
          ],
        ),
        body: navigateTo(),
      ),
    );
  }
}
