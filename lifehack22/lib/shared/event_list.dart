import 'package:flutter/material.dart';
import 'package:lifehack22/shared/event_card.dart';
import 'package:provider/provider.dart';

import '../event.dart';

class EventList extends StatefulWidget {

  final String username;

  const EventList({
    required this.username,
    Key? key
  }) : super(key: key);

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
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
          return EventCard(event: list[index], uid: widget.username);
        }
    );
  }
}