import 'package:flutter/material.dart';

const textinputdecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);
const textformat = TextStyle(
    color: Colors.black,fontSize: 20.0,fontWeight:FontWeight.bold,fontFamily: "Merriweather"
);
