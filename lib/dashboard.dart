import 'package:flutter/material.dart';
import 'package:neighbourly/UserScreens/addIssue.dart';
import 'UserScreens/feed.dart';
import "UserScreens/curloc.dart";
import 'getStarted.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UserScreens/myposts.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget navigateTo() {
    switch (_currentIndex) {
      case 0:
        {
          return CurLoc();
        }
      case 1:
        {
          return Feed();
        }
        break;
      case 2:
        {
          return AddIssue();
        }
      case 3:
        {
          return Myposts();
        }
      default:
        {
          return Text('What!!!!!');
        }
        break;
    }
  }

  void logout() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Neighbourly'),
          actions: [
            RaisedButton(
              color: Colors.orange,
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                logout();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GetStarted()),
                );
              },
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined),
                label: 'Home',
                backgroundColor: Colors.orange),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Feed',
                backgroundColor: Colors.orange),
            BottomNavigationBarItem(
                icon: Icon(Icons.post_add_sharp),
                label: 'File an Issue',
                backgroundColor: Colors.orange),
            BottomNavigationBarItem(
                icon: Icon(Icons.my_library_books),
                label: 'My posts',
                backgroundColor: Colors.orange),
          ],
        ),
        body: navigateTo(),
      ),
    );
  }
}
