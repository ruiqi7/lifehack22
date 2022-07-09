import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifehack22/pages/organise/new_event.dart';
import 'package:lifehack22/shared/bar_widgets.dart';
import 'package:lifehack22/shared/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../models/event.dart';
import '../../services/event_database.dart';
import '../../services/user_database.dart';
import 'organiser_list.dart';

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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: Container(
            color: darkestPink,
            child: SafeArea(
              child: Center(
                child: Container(
                    color: darkestPink,
                    height: 75,
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: Row(
                        children: [
                          AutoSizeText(
                            'Organised Events',
                            style: helveticaTextStyle.copyWith(fontSize: 31, fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                          const SizedBox(width: 5.0),
                          TextButton(
                            onPressed: () async {
                              bool result = await DatabaseService(uid: uid).isThereInfo();
                              if (result) {
                                if (!mounted) return;
                                Navigator.push(
                                  context,
                                  PageTransition(child: const NewEvent(), type: PageTransitionType.bottomToTop),
                                );
                              } else {
                                alertDialogueProfile(context);
                              }

                            },
                            child: const Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                              size: 40.0,
                            ),
                          ),
                        ],
                      ),
                    )
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
                      value: EventDatabase().organisingEventsStream(uid),
                      initialData: const [],
                      child: Flexible(
                          child: OrganiserList(username: uid)
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: navBarGrey,
          child: navigationBar(context, _position),
        )
    );
  }
}
