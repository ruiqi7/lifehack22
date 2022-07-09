import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifehack22/pages/organise/new_event.dart';
import 'package:lifehack22/shared/bar_widgets.dart';
import 'package:lifehack22/shared/constants.dart';
import 'package:page_transition/page_transition.dart';

class Organise extends StatefulWidget {
  const Organise({Key? key}) : super(key: key);

  @override
  State<Organise> createState() => _OrganiseState();
}

class _OrganiseState extends State<Organise> {

  final int _position = 3;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: SafeArea(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(child: const NewEvent(), type: PageTransitionType.bottomToTop),
                );
              },
              child: const Icon(
                Icons.add_circle_outline,
                color: darkestPink,
                size: 300.0,
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: navBarGrey,
          child: navigationBar(context, _position, uid),
        )
    );
  }
}
