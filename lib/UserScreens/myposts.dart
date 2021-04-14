import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class Myposts extends StatefulWidget {
  @override
  _MypostsState createState() => _MypostsState();
}

class _MypostsState extends State<Myposts> {
  @override
  void initState() {
    super.initState();
    getPosts();
  }

  var a = [];
  String email;
  void getPosts() async {
    a = [];
    SharedPreferences sp = await SharedPreferences.getInstance();
    email = sp.get('email');
    print(email);
    var response = await http.get(
        Uri.parse('https://neighbourly12.herokuapp.com/userpost?email=$email'));
    var decoded = jsonDecode(response.body);
    print(decoded);
    setState(() {
      decoded.forEach((name, value) {
        print(name);
        print(value);
        a.add([
          name,
          value['description'],
          value['flair'],
          value['lat'],
          value['long'],
          value['title'],
          value['status']
        ]);
      });
    });

    print(a);
  }

  void deletePost(String id) async {
    var response = await http.get(Uri.parse(
        'https://neighbourly12.herokuapp.com/crud?wat=delete&postid=$id&email=$email'));

    getPosts();
  }

  void updatePost(String id, String lat, String lon) async {
    var response = await http.get(Uri.parse(
        'https://neighbourly12.herokuapp.com/crud?wat=update&description=$description&flair=$type&lat=$lat&long=$lon&title=$title&status=$status&email=$email&postid=$id'));
    print(response);
    getPosts();
  }

  String type = 'Issue';
  String status = 'SOLVED';
  String title;
  String description;
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
                      title: Text('title: ${a[index][5]}',
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 20))),
                    ),
                    ListTile(
                      title: Text('description:${a[index][1]}',
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 20))),
                    ),
                    ListTile(
                      title: Text('flair: ${a[index][2]}',
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 20))),
                    ),
                    ListTile(
                      title: Text('Status: ${a[index][6]}',
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 20))),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        RaisedButton(
                            child: Text('Delete'),
                            color: Colors.red,
                            onPressed: () {
                              deletePost(a[index][0]);
                              // Navigator.pushReplacementNamed(
                              //     context, '/dashboard');
                            }),
                        SizedBox(width: 10),
                        RaisedButton(
                            child: Text('Update'),
                            color: Colors.green,
                            onPressed: () {
                              setState(() {
                                type = a[index][2];
                                status = a[index][6];
                                title = a[index][5];
                                description = a[index][1];
                              });

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: Text('Update info'),
                                        actions: [
                                          TextField(
                                            controller: TextEditingController()
                                              ..text = title,
                                            onChanged: (text) {
                                              setState(() {
                                                title = text;
                                              });
                                            },
                                            maxLines: null,
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.title_rounded),
                                              hintText: 'Title',
                                            ),
                                          ),
                                          TextField(
                                            controller: TextEditingController()
                                              ..text = description,
                                            onChanged: (text) {
                                              setState(() {
                                                description = text;
                                              });
                                            },
                                            maxLines: null,
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.title_rounded),
                                              hintText: 'Description',
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            width: double.infinity,
                                            child: DropdownButton<String>(
                                              value: type,
                                              items: <String>[
                                                'Issue',
                                                'Event',
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (String val) {
                                                setState(() {
                                                  type = val;
                                                  print(type);
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            width: double.infinity,
                                            child: DropdownButton<String>(
                                              value: status,
                                              items: <String>[
                                                'SOLVED',
                                                'UNSOLVED',
                                                'CONCLUDED',
                                                'NOT CONCLUDED'
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (String val) {
                                                setState(() {
                                                  status = val;
                                                  print(status);
                                                });
                                              },
                                            ),
                                          ),
                                          RaisedButton(
                                              onPressed: () {
                                                updatePost(
                                                  a[index][0],
                                                  a[index][3],
                                                  a[index][4],
                                                );
                                                Navigator.pop(context);
                                              },
                                              child: Text('Save'))
                                        ],
                                      ));
                            }),
                      ],
                    )
                  ]),
                );
              },
            ),
          );
  }
}
