import 'package:flutter/material.dart';
import 'package:lifehack22/shared/bar_widgets.dart';
import 'package:lifehack22/shared/constants.dart';

class Organise extends StatefulWidget {
  const Organise({Key? key}) : super(key: key);

  @override
  State<Organise> createState() => _OrganiseState();
}

class _OrganiseState extends State<Organise> {

  final int _position = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(),
        bottomNavigationBar: Container(
          color: navBarGrey,
          child: navigationBar(context, _position),
        )
    );
  }
}
