import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../event.dart';
import 'constants.dart';
import 'event_details.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final String uid;
  const EventCard({Key? key, required this.event, required this.uid}) : super(key: key);

  int numOfPeopleNeeded() {
    dynamic i = event.quota;
    dynamic j = event.participantsList.length;
    return i - j + 1;
  }

  @override
  Widget build(BuildContext context) {

    final int nPeopleNeeded = numOfPeopleNeeded();

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
                child: Center(child: Image(image: NetworkImage(event.imageUrl))),
              ),
              horizontalGapBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      AutoSizeText(event.title, style: helveticaTextStyle.copyWith(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black), maxLines: 1),
                      horizontalGapBox,
                      // Date & Time
                      Row(
                        children: <Widget> [
                          const Icon(
                            Icons.access_time,
                            color: Colors.black,
                          ),
                          verticalGapBox,
                          AutoSizeText(event.dateTime.toString().substring(0,4), style: helveticaTextStyle.copyWith(fontSize: 20, color: Colors.black), maxLines: 1),
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
                          AutoSizeText(event.region, style: helveticaTextStyle.copyWith(fontSize: 20, color: Colors.black), maxLines: 1),
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
                          AutoSizeText('$nPeopleNeeded more!', style: helveticaTextStyle.copyWith(fontSize: 20, color: Colors.black), maxLines: 1),

                        ],
                      ),
                      horizontalGapBox,
                      Row(
                        children: <Widget> [
                          Container(
                            decoration: largeRadiusRoundedBox,
                            padding: const EdgeInsets.all(7.5),
                            child: AutoSizeText(event.activityType, style: helveticaTextStyle.copyWith(fontSize: 20, color: Colors.black), maxLines: 1),
                          ),
                          verticalGapBox,
                          Container(
                            decoration: largeRadiusRoundedBox,
                            padding: const EdgeInsets.all(7.5),
                            child: AutoSizeText(event.community, style: helveticaTextStyle.copyWith(fontSize: 20, color: Colors.black), maxLines: 1),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                          PageTransition(
                            child: EventDetails(event: event, uid: uid),
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
