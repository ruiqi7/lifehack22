import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lifehack22/models/event.dart';
import 'package:lifehack22/shared/constants.dart';

class OrganiserDetails extends StatefulWidget {
  final Event event;
  final String uid;
  const OrganiserDetails({Key? key, required this.event, required this.uid}) : super(key: key);

  @override
  State<OrganiserDetails> createState() => _OrganiserDetailsState();
}

class _OrganiserDetailsState extends State<OrganiserDetails> {

  int numOfPeopleNeeded() {
    dynamic i = widget.event.quota;
    dynamic j = widget.event.participantsList.length;
    return i - j + 1;
  }

  @override
  Widget build(BuildContext context) {

    final int nPeopleNeeded = numOfPeopleNeeded();

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
                child: Container(
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
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [
            Container(
              height: 150,
              color: transparent,
              child: Center(child: Image(image: NetworkImage(widget.event.imageUrl))),
            ),
            horizontalGapBox,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  AutoSizeText(widget.event.title, style: helveticaTextStyle.copyWith(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black), maxLines: 1),
                  horizontalGapBox,
                  // Date & Time
                  Row(
                    children: <Widget> [
                      const Icon(
                        Icons.access_time,
                        color: Colors.black,
                      ),
                      verticalGapBox,
                      AutoSizeText("widget.event.dateTime", style: helveticaTextStyle.copyWith(fontSize: 20, color: Colors.black), maxLines: 1),
                    ],
                  ),
                  const SizedBox(height: 5.0),
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
                  const SizedBox(height: 5.0),
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
                        child: AutoSizeText(widget.event.activityType, style: helveticaTextStyle.copyWith(fontSize: 20, color: Colors.black), maxLines: 1),
                      ),
                      verticalGapBox,
                      Container(
                        decoration: largeRadiusRoundedBox,
                        padding: const EdgeInsets.all(7.5),
                        child: AutoSizeText(widget.event.community, style: helveticaTextStyle.copyWith(fontSize: 20, color: Colors.black), maxLines: 1),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.event.details,
                    style: helveticaTextStyle.copyWith(color: Colors.black, fontSize: 20),
                  ),
                  horizontalGapBox,
                  Container(
                    height: 150,
                    decoration: smallRadiusRoundedBox,
                    padding: const EdgeInsets.all(15.0),
                    child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget> [
                          Text(
                            'Contact',
                            style: helveticaTextStyle.copyWith(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          horizontalGapBox,
                          Row(
                            children: <Widget> [
                              const Icon(
                                Icons.person_rounded,
                                color: Colors.black,
                              ),
                              verticalGapBox,
                              AutoSizeText(widget.event.contactName, style: helveticaTextStyle.copyWith(fontSize: 20, color: Colors.black), maxLines: 1),
                              const SizedBox(height: 5.0),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          Row(
                            children: <Widget> [
                              const Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),
                              verticalGapBox,
                              AutoSizeText(widget.event.contactNumber, style: helveticaTextStyle.copyWith(fontSize: 20, color: Colors.black), maxLines: 1),
                              const SizedBox(height: 5.0),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          Row(
                            children: <Widget> [
                              const Icon(
                                Icons.email_outlined,
                                color: Colors.black,
                              ),
                              verticalGapBox,
                              AutoSizeText(widget.event.contactEmail, style: helveticaTextStyle.copyWith(fontSize: 20, color: Colors.black), maxLines: 1),
                              const SizedBox(height: 5.0),
                            ],
                          ),
                        ],
                      )
                  ),
                  horizontalGapBox,
                  Center(
                    child: Container(
                      decoration: largeRadiusRoundedBox1,
                      padding: const EdgeInsets.all(5.0),
                      child: TextButton(
                        onPressed: () {

                        },
                        child: Text(
                          'View Participants',
                          style: helveticaTextStyle.copyWith(fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35.0)
                ],
              ),
            )
          ],
        )
      )
    );
  }
}
