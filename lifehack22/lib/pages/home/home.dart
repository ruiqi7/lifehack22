import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lifehack22/services/event_database.dart';
import 'package:lifehack22/shared/bar_widgets.dart';
import 'package:lifehack22/shared/constants.dart';
import 'package:provider/provider.dart';

import '../../event.dart';
import '../../shared/event_list.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final int _position = 1;
  String uid = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget> [
          Container(
            color: darkestPink,
            child: SafeArea(
              child: Container(
                color: darkestPink,
                height: 180,
                padding: const EdgeInsets.only(left: 40.0, right: 10.0),
                child: Column(
                  children: <Widget> [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const <Widget> [
                        Icon(
                          Icons.logout_outlined,
                          color: Colors.white,
                          size: 40,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AutoSizeText('Welcome', style: helveticaTextStyle.copyWith(fontSize: 52, fontWeight: FontWeight.bold), maxLines: 1),
                      ],
                    ),
                    horizontalGapBox,
                    Row(
                      children: <Widget> [
                        AutoSizeText('Back!', style: helveticaTextStyle.copyWith(fontSize: 52, fontWeight: FontWeight.bold), maxLines: 1),
                        verticalGapBox,
                        const Icon(
                          Icons.waving_hand,
                          color: Colors.white,
                          size: 50,
                        ),
                      ],
                    ),
                  ],
                )
              ),
            ),
          ),
          horizontalGapBox,
          horizontalGapBox,
          Expanded(child: AutoSizeText('Your Upcoming Events', style: helveticaTextStyle.copyWith(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black))),
          horizontalGapBox,
          horizontalGapBox,
          Expanded(
            child: Column(
              children: <Widget> [
                StreamProvider<List<Event>>.value(
                  value: EventDatabase().homeEventsStream(uid),
                  initialData: const [],
                  child: Flexible(
                      child: EventList(username: uid)
                  ),
                ),
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: Container(
        color: navBarGrey,
        child: navigationBar(context, _position),
      )
    );
  }
}
