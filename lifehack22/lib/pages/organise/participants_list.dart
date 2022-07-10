import 'package:flutter/material.dart';
import 'package:lifehack22/pages/organise/participants_card.dart';
import 'package:lifehack22/shared/event_card.dart';
import 'package:provider/provider.dart';
import 'package:lifehack22/models/app_user.dart';

class ParticipantsList extends StatefulWidget {

  final String username;

  const ParticipantsList({
    required this.username,
    Key? key
  }) : super(key: key);

  @override
  State<ParticipantsList> createState() => _ParticipantsListState();
}

class _ParticipantsListState extends State<ParticipantsList> {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<List<AppUser>>(context);
    List<AppUser> list = [];
    for (var e in events) {
      list.add(e);
    }

    return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ParticipantsCard(appUser: list[index], position: index + 1);
        }
    );
  }
}