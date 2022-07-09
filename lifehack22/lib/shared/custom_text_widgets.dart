import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lifehack22/shared/constants.dart';

// Header using the Helvetica font for the Menu pages
class HelveticaHeader extends StatelessWidget {
  final String text;

  const HelveticaHeader({
    Key? key,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: AutoSizeText(
        text,
        textAlign: TextAlign.center,
        style: helveticaTextStyle.copyWith(fontSize: 60.0, fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
    );
  }
}