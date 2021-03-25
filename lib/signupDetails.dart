import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class SignupDetails extends StatefulWidget {
  @override
  _SignupDetailsState createState() => _SignupDetailsState();
}

class _SignupDetailsState extends State<SignupDetails> {

  double height=0;
  double width=0;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width/30,vertical: height/10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.centerLeft,
              height: 90,
              child: TextFormField(
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9.@]'))],
                controller: emailController,
                validator: (val){
                  if(EmailValidator.validate(val)){
                    return null;
                  }
                  return 'Invalid E-mail ID';
                },
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Colors.grey
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Colors.grey
                    ),
                  ),
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.grey,
                  ),
                  hintText: 'E-mail',
                  hintStyle: kHintTextStyle,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              height: 60.0,
              child: TextFormField(
                controller: passwordController,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))],
                validator: (val){
                  if(val.isEmpty){
                    return 'Password should not be empty';
                  }
                  return null;
                },
                obscureText: true,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Colors.grey
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Colors.grey
                    ),
                  ),
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
                  hintText: 'Password',
                  hintStyle: kHintTextStyle,
                ),
              ),
            ),
            SizedBox(
              height: height/20,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 25.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()async{
                  if(_formKey.currentState.validate()){

                    print('Successful');
                    String encodedPassword=Uri.encodeComponent(passwordController.text);

                    try{
                      var response= await http.get(
                        Uri.parse('https://neighbourly12.herokuapp.com/signup?email=${emailController.text}&password=$encodedPassword'),
                      );
                      print(response.body);
                      if(response.statusCode==200){
                        Navigator.pushReplacementNamed(context, '/loginDetails');
                      }
                    }
                    catch(e){
                      print('The Exception is'+e);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  onPrimary: Color(0xFFB40284A),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                // padding: EdgeInsets.all(15.0),
                // color: Color(0xFFB40284A),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}