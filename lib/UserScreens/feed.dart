import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:neighbourly/constants.dart';
import 'package:provider/provider.dart';
import '../dataForPosts.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create: (context){
        return Data();
      },
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

  void getPosts()async{

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lat=position.latitude;
    var long=position.longitude;

    var response=await http.get(Uri.parse('https://neighbourly12.herokuapp.com/viewpost?lat=$lat&long=$long'));
    var decoded=response.body;
    var decoded1=jsonDecode(decoded);
    List<String> posts=[];

    print(decoded1["hpyes619"][0]);

    decoded=decoded.replaceAll('{','');
    decoded=decoded.replaceAll('}','');
    decoded=decoded.replaceAll('"','');
    decoded=decoded.replaceAll(',',':');
    posts=decoded.split(':');



    for(var i=0;i<posts.length;i++){
      // print("${posts[i]} - $i");
      switch(i%12){

        case 0:{
          Provider.of<Data>(context,listen: false).addUser(posts[i]);
        }
        break;

        case 3:{
          Provider.of<Data>(context,listen: false).addDescription(posts[i]);
        }
        break;

        case 5:{
          Provider.of<Data>(context,listen: false).addFlair(posts[i]);
        }
        break;

        case 11:{
          Provider.of<Data>(context,listen: false).addTitle(posts[i]);
        }
        break;

        default: {
          continue;
        }
      }
    }

    // print(posts);
  }

  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(vertical: height/20,horizontal: width/20),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: Provider.of<Data>(context).viewCount(),
        itemBuilder: (context,index){
          return ListOfPosts(index:index);
        },
      ),
    );
  }
}


class ListOfPosts extends StatelessWidget {

  final index;

  ListOfPosts({this.index});

  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;

    return Container(
      height: height/2,
      padding: EdgeInsets.symmetric(vertical: height/15),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Column(
          children: [
            ListTile(
              leading: Text('${Provider.of<Data>(context).viewUser(index)}',style: kLabelStyle,),
              trailing: Text('${Provider.of<Data>(context).viewFlair(index)} : ${Provider.of<Data>(context).viewTitle(index)}',style: kLabelStyle),
            ),
            SizedBox(
              height: height/10,
            ),
            Text('${Provider.of<Data>(context).viewDescription(index)}',style: kDescriptionStyle),
          ],
        ),
      ),
    );

  }
}

