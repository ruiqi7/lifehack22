import 'package:auto_size_text/auto_size_text.dart';
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

const TextStyle formInputTextStyle = TextStyle(
  fontFamily: 'Helvetica',
  letterSpacing: 1.5,
  color: darkestPink,
);

const BoxDecoration smallRadiusRoundedBox1 = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  color: darkestPink,
);

const BoxDecoration largeRadiusRoundedBox1 = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(30.0)),
  color: darkestPink,
);

const InputDecoration formFieldDeco = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  hintStyle: TextStyle(color: darkestPink),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: darkestPink,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: darkestPink,
      width: 2.0,
    ),
  ),
  isDense: true,
  contentPadding: EdgeInsets.all(10.0),
);

backButton(context) => Container(
  width: 100.0,
  height: 40.0,
  decoration: largeRadiusRoundedBox1,
  child: TextButton(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(5.0),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
    child: AutoSizeText(
      'Back',
      style: helveticaTextStyle.copyWith(fontSize: 20.0),
      maxLines: 1
    ),
  ),
);

BoxDecoration smallRadiusRoundedBox = const BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  color: darkestPinkOpacity10,
);

BoxDecoration largeRadiusRoundedBox = BoxDecoration(
  borderRadius: const BorderRadius.all(Radius.circular(30)),
  border: Border.all(color: darkestPink, width: 1.0),
  color: lightPink,
);