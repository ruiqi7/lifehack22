import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifehack22/shared/bar_widgets.dart';
import 'package:lifehack22/shared/constants.dart';
import 'package:lifehack22/shared/event_details.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../models/event.dart';
import '../../services/event_database.dart';
import '../../shared/event_list.dart';

class Volunteer extends StatefulWidget {
  const Volunteer({Key? key}) : super(key: key);

  @override
  State<Volunteer> createState() => _VolunteerState();
}

class _VolunteerState extends State<Volunteer> {

  final int _position = 2;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: Container(
            color: darkestPink,
            child: SafeArea(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  color: darkestPink,
                  height: 75,
                  child: Text(
                    'Upcoming Events',
                     style: helveticaTextStyle.copyWith(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: <Widget> [
            horizontalGapBox,
            horizontalGapBox,
            Expanded(
              child: Column(
                children: <Widget> [
                  StreamProvider<List<Event>>.value(
                    value: EventDatabase().volunteeringEventsStream(),
                    initialData: const [],
                    child: Flexible(
                        child: EventList(username: uid)
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: navBarGrey,
          child: navigationBar(context, _position, uid),
        )
    );
  }
}