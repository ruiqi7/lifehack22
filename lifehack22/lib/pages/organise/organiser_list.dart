import 'package:flutter/material.dart';
import 'package:lifehack22/pages/organise/organiser_card.dart';
import 'package:lifehack22/shared/event_card.dart';
import 'package:provider/provider.dart';

import 'package:lifehack22/models/event.dart';

class OrganiserList extends StatefulWidget {

  final String username;

  const OrganiserList({
    required this.username,
    Key? key
  }) : super(key: key);

  @override
  State<OrganiserList> createState() => _OrganiserListState();
}

class _OrganiserListState extends State<OrganiserList> {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<List<Event>>(context);
    List<Event> list = [];
    for (var e in events) {
      list.add(e);
    }
    list.sort((a, b) => b.compareTo(a));

    return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length <= 20 ? list.length : 20,
        itemBuilder: (context, index) {
          return OrganiserCard(event: list[index], uid: widget.username);
        }
    );
  }
}