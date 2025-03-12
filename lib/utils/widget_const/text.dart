import 'package:flutter/material.dart';

class Teks {
  static Text biasa(String text, {FontWeight? fw, double? fs, TextAlign? ta = TextAlign.left}) {
    return Text(
      text,
      textAlign: ta,
      style: TextStyle(
        fontWeight: fw,
        fontSize: fs
      ),
    );
  }

  static Text spesial(String text, {double? fs}){
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fs,
        fontFamily: "Kavoon"
      ),
    );
  }
  
}