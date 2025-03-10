import 'dart:ui';

import 'package:flutter/material.dart';

Text teksMainScreen(String text, {FontWeight? fw, double? fs}) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: fw,
      fontSize: fs
    ),
  );
}