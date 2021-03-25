import 'package:flutter/material.dart';

class AddIssue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _titleController=TextEditingController();
    final _descriptionController=TextEditingController();
    final _flairController=TextEditingController();
    final height= MediaQuery.of(context).size.height;
    final width= MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              controller: _titleController,
            ),
            SizedBox(height: height/10,),
            TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(

              ),
              controller: _descriptionController,
            ),
            SizedBox(height: height/10,),
            TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              controller: _flairController,
            ),
            SizedBox(height: height/10,),
            ElevatedButton(
              onPressed: ()async{
                //Navigator.pushReplacementNamed(context, '/dashboard');
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
                'LOGIN',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}

// Email title description flair lat lon