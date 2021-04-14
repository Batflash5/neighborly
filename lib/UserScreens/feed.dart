import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:neighbourly/constants.dart';
import 'package:provider/provider.dart';
import '../dataForPosts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ViewPosts(),
    );
  }
}

class ViewPosts extends StatefulWidget {
  @override
  _ViewPostsState createState() => _ViewPostsState();
}

class _ViewPostsState extends State<ViewPosts> {
  @override
  void initState() {
    super.initState();
    getPosts();
  }

  var a = [];
  void getPosts() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;

    var response = await http.get(Uri.parse(
        'https://neighbourly12.herokuapp.com/viewpost?lat=$lat&long=$long'));
    var decoded = jsonDecode(response.body);
    // print(jsonDecode(response.body));

    // var decoded1 = jsonDecode(decoded);
    // Map<String, dynamic> myMap = json.decode(decoded);
    setState(() {
      decoded.forEach((name, value) {
        decoded[name].forEach((key, value) {
          a.add([
            name,
            key,
            value['description'],
            value['flair'],
            value['lat'],
            value['long'],
            value['title'],
            value['status']
          ]);
        });
      });
    });

    print(a);
  }

  @override
  Widget build(BuildContext context) {
    return a.length == 0
        ? SpinKitPouringHourglass(
            color: Colors.white,
            size: 50.0,
          )
        : Container(
            child: ListView.builder(
              itemCount: a.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.deepPurple,
                  elevation: 5,
                  child: Column(children: [
                    ListTile(
                      title: Text('Name:${a[index][0]}',
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 20))),
                    ),
                    ListTile(
                      title: Text('Title: ${a[index][6]}',
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 20))),
                    ),
                    ListTile(
                      title: Text('Type:${a[index][3]}',
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 20))),
                    ),
                    ListTile(
                      title: Text('Description: ${a[index][2]}',
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 20))),
                    ),
                    Card(
                      color: Colors.green,
                      elevation: 5,
                      child: ListTile(
                        title: Text('Status: ${a[index][7]}',
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20))),
                      ),
                    ),
                  ]),
                );
              },
            ),
          );
  }
}
