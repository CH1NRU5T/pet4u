import 'package:flutter/material.dart';
import 'package:pet4u/models/pet_model.dart';

class CustomColors {
  static Color dogColor = const Color(0xffFBD9B9);
  static Color catColor = const Color(0xffF2B6F7);
  static Color otherColor = const Color(0xffF7B6BE);
  static Color ageColor = const Color(0xffFBD9B9);
  static Color weightColor = const Color(0xffF2B6F7);
  static Color heightColor = const Color(0xffF7B6BE);
  static Color textButtonBackgroundColor = const Color(0xff9088E4);
  static Color getColorForSpecie(Species species) {
    switch (species) {
      case Species.dog:
        return dogColor;
      case Species.cat:
        return catColor;
      case Species.other:
        return otherColor;
    }
  }
}
