import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Color(0xFF383838),
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kDescriptionStyle=TextStyle(
  color: Colors.black,
  textBaseline: TextBaseline.alphabetic,
  fontWeight: FontWeight.normal,
  fontFamily: 'OpenSans'
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);