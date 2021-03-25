import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:neighbourly/signupDetails.dart';
import 'loginDetails.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {

  double height=0;
  double width=0;
  int _pageState=0;
  Color _backgroundColor=Colors.white;
  Color _textColor=Colors.black;
  double _loginYOffset=0;
  bool _isLogin=false;


  @override
  Widget build(BuildContext context) {

    bool _isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);

    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;

    switch(_pageState){
      case 0:
        _backgroundColor=Colors.white;
        _textColor=Colors.black;
        _loginYOffset=height;
        break;
      case 1:
        _backgroundColor=Color(0xFFD34D5B);
        _textColor=Colors.white;
        _loginYOffset=_isKeyboardVisible?height/6:height/3;
        break;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    _pageState=0;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                child: AnimatedContainer(
                  color: _backgroundColor,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: Duration(
                    milliseconds: 800,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: width/50,vertical: height/50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height:height/20),
                      Container(
                        margin: EdgeInsets.only(top: height/15),
                        child: Text(
                          "Neighbourly",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _textColor,
                            fontFamily: "WorkSans",
                            fontWeight: FontWeight.bold,
                            fontSize: height/30,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Image(
                          width: width/1.4,
                          height: height/1.4,
                          image: AssetImage('images/ppl1.png'),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _isLogin=false;
                            _pageState=1;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(width/30),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xFF000000),Color(0xFF53346D),Color(0xFF000000)]
                            ),
                            borderRadius: BorderRadius.circular(width/10),
                          ),
                          child: Center(
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "WorkSans",
                                fontSize: height/40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height/20,
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _isLogin=true;
                            _pageState=1;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(width/30),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF870000),Color(0xFF190A05),Color(0xFF870000)]
                            ),
                            borderRadius: BorderRadius.circular(width/10),
                          ),
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "WorkSans",
                                fontSize: height/40,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(
                    milliseconds: 1000
                ),
                transform: Matrix4.translationValues(0, _loginYOffset, 1),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    )
                ),
                child: _isLogin?LoginDetails():SignupDetails(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

