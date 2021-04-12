import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddIssue extends StatefulWidget {
  @override
  _AddIssueState createState() => _AddIssueState();
}

class _AddIssueState extends State<AddIssue> {

  var _titleController=TextEditingController();
  var _descriptionController=TextEditingController();
  String _value='Issue';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final height= MediaQuery.of(context).size.height;
    final width= MediaQuery.of(context).size.width;

    bool _isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);
    double _loginYOffset=_isKeyboardVisible?height/10:height/5;

    return SafeArea(
      child: KeyboardDismissOnTap(
        child: Scaffold(
          body: AnimatedContainer(
            padding: EdgeInsets.symmetric(horizontal: width/10),
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(
              milliseconds: 800,
            ),
            transform: Matrix4.translationValues(0, _loginYOffset, 1),
            child: Column(
              children: [
                TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: _titleController,
                  decoration: InputDecoration(
                    icon: Icon(
                        Icons.title_rounded
                    ),
                    hintText: 'Title',
                  ),
                ),
                SizedBox(height: height/10,),
                TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    icon: Icon(
                        Icons.wysiwyg
                    ),
                    hintText: 'Description',
                  ),
                  controller: _descriptionController,
                ),
                SizedBox(height: height/10,),
                Container(
                  width: double.infinity,
                  child: DropdownButton<String>(
                    value: _value,
                    items: <String>['Issue', 'Event', 'Meme'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String val) {
                      setState(() {
                        _value=val;
                        print(_value);
                      });
                    },
                  ),
                ),
                SizedBox(height: height/10,),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: ()async{
                      String t=_titleController.text;
                      String d=_descriptionController.text;
                      String f=_value;
                      SharedPreferences sp=await SharedPreferences.getInstance();
                      String e=sp.get('email');

                      try{
                        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                        var lat=position.latitude;
                        var lon=position.longitude;
                        var response =await http.get(
                            Uri.parse(
                            'https://neighbourly12.herokuapp.com/newpost?email=$e&title=$t&desc=$d&flair=$f&lat=$lat&long=$lon'));
                        if(response.statusCode==200){
                          Navigator.pushReplacementNamed(context, '/dashboard');
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not post')));
                        }
                      }
                      catch(e){
                        print(e);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      onPrimary: Color(0xFFB40284A),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'ADD',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
