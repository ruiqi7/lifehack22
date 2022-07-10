import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lifehack22/pages/organise/participants_list.dart';
import 'package:provider/provider.dart';

import '../../models/app_user.dart';
import '../../services/user_database.dart';
import '../../shared/constants.dart';

class ViewParticipants extends StatefulWidget {
  final String uid;
  final List<dynamic> list;
  const ViewParticipants({Key? key, required this.uid, required this.list}) : super(key: key);

  @override
  State<ViewParticipants> createState() => _ViewParticipantsState();
}

class _ViewParticipantsState extends State<ViewParticipants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: Container(
          color: darkestPink,
          child: SafeArea(
            child: Center(
              child: Container(
                color: darkestPink,
                height: 75,
                child: Row(
                  children: [
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
                      'View Participants',
                      style: helveticaTextStyle.copyWith(fontSize: 30.0),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Column(
                children: <Widget> [
                  StreamProvider<List<AppUser>>.value(
                    value: DatabaseService(uid: widget.uid).viewParticipantsStream(widget.list, widget.uid),
                    initialData: const [],
                    child: Flexible(
                        child: ParticipantsList(username: widget.uid)
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