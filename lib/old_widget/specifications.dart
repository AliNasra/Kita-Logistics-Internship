import 'package:flutter/material.dart';

const colorBlack = Color.fromARGB(0, 5, 5, 5);
const colorYellow = Color.fromARGB(245, 250, 246, 13);
const colorWhite = Color.fromARGB(255, 255, 255, 255);
const colorGrey = Color.fromARGB(225, 238, 239, 245);

const TextTheme textThemeDefault = TextTheme(
  displaySmall : TextStyle(
    color: colorWhite ,fontWeight: FontWeight.bold ,fontSize: 48 
  ),
  headlineMedium: TextStyle(
     color: colorGrey ,fontWeight: FontWeight.bold ,fontSize: 32
  ),
  titleMedium: TextStyle(
     color: colorGrey ,fontWeight: FontWeight.bold ,fontSize: 48
  )
);