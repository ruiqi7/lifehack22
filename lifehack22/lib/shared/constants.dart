import 'package:flutter/material.dart';

const darkestPink = Color.fromRGBO(178, 0, 86, 1.0);
const darkestPinkOpacity10 = Color.fromRGBO(178, 0, 86, 0.1);
const navBarGrey = Color.fromRGBO(235, 235, 235, 1.0);
const navBarObjGrey = Color.fromRGBO(115, 115, 115, 1.0);
const transparent = Color.fromRGBO(255, 255, 255, 0);
const lightPink = Color.fromRGBO(253, 207, 235, 1.0);

const horizontalGapBox = SizedBox(height: 15);
const verticalGapBox = SizedBox(width: 15);

const TextStyle helveticaTextStyle = TextStyle(
  fontFamily: 'Helvetica',
  letterSpacing: 1.5,
  color: Colors.white,
);

const BoxDecoration smallRadiusRoundedBox = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  color: darkestPinkOpacity10,
);

BoxDecoration largeRadiusRoundedBox = BoxDecoration(
  borderRadius: const BorderRadius.all(Radius.circular(30)),
  border: Border.all(color: darkestPink, width: 1.0),
  color: lightPink,
);