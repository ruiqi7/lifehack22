import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifehack22/models/event.dart';
import 'package:lifehack22/services/user_database.dart';
import 'package:lifehack22/shared/constants.dart';
import 'package:page_transition/page_transition.dart';

import 'organiser_details.dart';

class OrganiserCard extends StatefulWidget {
  final Event event;
  final String uid;
  const OrganiserCard({Key? key, required this.event, required this.uid}) : super(key: key);

  @override
  State<OrganiserCard> createState() => _OrganiserCardState();
}

class _OrganiserCardState extends State<OrganiserCard> {
  String currStatus() {
    int i = widget.event.quota;
    int j = widget.event.participantsList.length;
    int subtraction = j - 1;
    return "$subtraction/$i";
  }

  @override
  Widget build(BuildContext context) {
    final String status = currStatus();

    return Column(
      children: <Widget> [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            padding: const EdgeInsets.all(15.0),
            decoration: smallRadiusRoundedBox,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Container(
                  height: 100,
                  color: transparent,
                  child: Center(child: Image(image: NetworkImage(widget.event.imageUrl))),
                ),
                horizontalGapBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                        AutoSizeText(
                            widget.event.title,
                            style: helveticaTextStyle.copyWith(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
                            maxLines: 1
                        ),
                        horizontalGapBox,
                        // Date & Time
                        Row(
                          children: <Widget> [
                            const Icon(
                              Icons.access_time,
                              color: Colors.black,
                            ),
                            verticalGapBox,
                            AutoSizeText(
                                '${DateFormat.yMMMd().format(widget.event.dateTime.toDate())} @ ${DateFormat.Hm().format(widget.event.dateTime.toDate())}',
                                style: helveticaTextStyle.copyWith(fontSize: 20, color: Colors.black),
                                maxLines: 1,
                            ),
                          ],
                        ),
                        // Location
                        Row(
                          children: <Widget> [
                            const Icon(
                              Icons.location_on_rounded,
                              color: Colors.black,
                            ),
                            verticalGapBox,
                            AutoSizeText(widget.event.region, style: helveticaTextStyle.copyWith(fontSize: 20, color: Colors.black), maxLines: 1),
                          ],
                        ),
                        // x Number more people
                        Row(
                          children: <Widget> [
                            const Icon(
                              Icons.people_alt,
                              color: Colors.black,
                            ),
                            verticalGapBox,
                            AutoSizeText(status, style: helveticaTextStyle.copyWith(fontSize: 20, color: Colors.black), maxLines: 1),

                          ],
                        ),
                        horizontalGapBox,
                        Row(
                          children: <Widget> [
                            Container(
                              decoration: largeRadiusRoundedBox,
                              padding: const EdgeInsets.all(7.5),
                              child: AutoSizeText(widget.event.activityType, style: helveticaTextStyle.copyWith(fontSize: 20, color: Colors.black), maxLines: 1),
                            ),
                            verticalGapBox,
                            Container(
                              decoration: largeRadiusRoundedBox,
                              padding: const EdgeInsets.all(7.5),
                              child: AutoSizeText(widget.event.community, style: helveticaTextStyle.copyWith(fontSize: 20, color: Colors.black), maxLines: 1),
                            )
                          ],
                        )
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 30,
                      ),
                      onPressed: () async {
                        DatabaseService dbs = DatabaseService(uid: widget.event.organiserUid);
                        String contactName = await dbs.getName();
                        String contactPhone = await dbs.getPhone();
                        String contactEmail = await dbs.getEmail();

                        if (!mounted) return;

                        Navigator.push(
                            context,
                            PageTransition(
                              child: OrganiserDetails(
                                event: widget.event,
                                uid: widget.uid,
                                contactName: contactName,
                                contactPhone: contactPhone,
                                contactEmail: contactEmail,
                              ),
                              type: PageTransitionType.bottomToTop,
                            )
                        );
                      },
                    )
                  ],
                ),
              ],
            )
        ),
        horizontalGapBox,
      ],
    );
  }
}