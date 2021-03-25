import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Feed extends StatelessWidget {
  
  void getPosts()async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lat=position.latitude;
    var long=position.longitude;
    print(lat);
    print(long);
    var response=await http.get(Uri.parse('https://neighbourly12.herokuapp.com/viewpost?lat=$lat&long=$long'));
    print(response.body);
  }
  @override
  Widget build(BuildContext context) {
    getPosts();
    return Container();
  }
}
