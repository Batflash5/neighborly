import 'package:flutter/material.dart';

class Data extends ChangeNotifier{

  List<String> userName=[];
  List<String> description=[];
  List<String> title=[];
  List<String> flair=[];
  int count=0;

  void addUser(String name){

    userName.add(name);
    count+=1;
    notifyListeners();

  }
  void addDescription(String desc){

    description.add(desc);
    notifyListeners();

  }
  void addTitle(String tit){

    title.add(tit);
    notifyListeners();

  }
  void addFlair(String type){

    flair.add(type);
    notifyListeners();

  }

  String viewUser(int index)=>userName[index];
  String viewDescription(int index)=>description[index];
  String viewTitle(int index)=>title[index];
  String viewFlair(int index)=>flair[index];
  int viewCount()=>count;

}