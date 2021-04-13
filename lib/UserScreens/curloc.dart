import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart";
import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CurLoc extends StatefulWidget {
  @override
  _CurLocState createState() => _CurLocState();
}

class _CurLocState extends State<CurLoc> {
  @override
  void initState() {
    super.initState();
    getinfo();
  }

  var othLoc = [];
  Position position;
  var long, lat;
  void getinfo() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      long = position.longitude;
      lat = position.latitude;
    });
    print(long);
    SharedPreferences sp = await SharedPreferences.getInstance();
    e = sp.get('email');

    print(e);
    var response = await http.get(Uri.parse(
        'https://neighbourly12.herokuapp.com/currentLocation?email=${e.split('@')[0]}&lat=$lat&long=$long'));
    var decoded = jsonDecode(response.body);
    // print(decoded);
    setState(() {
      decoded.forEach((key, val) {
        othLoc.add([val['email'], val['lat'], val['long']]);
      });
    });

    print(othLoc);
  }

  String e;
  List<Marker> allMarkers = [];
  @override
  Widget build(BuildContext context) {
    return othLoc.length == 0
        ? SpinKitPouringHourglass(
            color: Colors.white,
            size: 50.0,
          )
        : Container(
            child: FlutterMap(
            options: new MapOptions(
                minZoom: 10.0, maxZoom: 100, center: new LatLng(lat, long)),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              MarkerLayerOptions(
                //   markers: [
                //   Marker(
                //     width: 80.0,
                //     height: 80.0,
                //     point: LatLng(position.latitude, position.longitude),
                //     builder: (ctx) => Container(
                //       child: IconButton(
                //           onPressed: () {
                //             showDialog(
                //                 context: context,
                //                 builder: (BuildContext context) => AlertDialog(
                //                       title: Text(
                //                           'Your Location (${position.latitude}, ${position.longitude})'),
                //                     ));
                //           },
                //           icon: Icon(
                //             Icons.location_on,
                //             color: Colors.red,
                //           )),
                //     ),
                //   ),
                // ]
                markers: _buildMarkersOnMap(),
              ),
            ],
          ));
  }

  List<Marker> _buildMarkersOnMap() {
    List<Marker> markers = List<Marker>();
    print('yo');
    var marker;

    othLoc.forEach((element) {
      print(element);
    });
    for (var i in othLoc) {
      print(i);
      if (i[0].contains(e.split('@')[0])) {
        continue;
      }
      marker = new Marker(
        point: LatLng(double.parse(i[1]), double.parse(i[2])),
        width: 279.0,
        height: 256.0,
        builder: (context) => new Container(
          child: Column(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text('${i[0]} : (${i[1]}, ${i[2]})'),
                            ));
                  }),
            ],
          ),
        ),
      );
      markers.add(marker);
      marker = new Marker(
        point: LatLng(lat, long),
        width: 279.0,
        height: 256.0,
        builder: (context) => new Container(
          child: Column(
            children: <Widget>[
              Text(
                'You',
              ),
              IconButton(
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.blue,
                    size: 40,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                  'Your Location (${position.latitude}, ${position.longitude})'),
                            ));
                  }),
            ],
          ),
        ),
      );
      markers.add(marker);
    }
    return markers;
  }
}
