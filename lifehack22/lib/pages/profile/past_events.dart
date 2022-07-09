import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifehack22/shared/bar_widgets.dart';
import 'package:lifehack22/shared/constants.dart';
import 'package:lifehack22/shared/event_details.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../event.dart';
import '../../services/event_database.dart';
import '../../shared/event_list.dart';

class PastEvents extends StatefulWidget {
  final String uid;
  const PastEvents({Key? key, required this.uid}) : super(key: key);

  @override
  State<PastEvents> createState() => _PastEventsState();
}

class _PastEventsState extends State<PastEvents> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: Container(
            color: darkestPink,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                color: darkestPink,
                height: 75,
                child: Row(
                  children: <Widget> [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        iconSize: 45.0,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    AutoSizeText(
                      'Your Past Events',
                       style: helveticaTextStyle.copyWith(fontSize: 33, fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                  ],
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
                    value: EventDatabase().pastEventsStream(widget.uid),
                    initialData: const [],
                    child: Flexible(
                        child: EventList(username: widget.uid)
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
    );
  }
}