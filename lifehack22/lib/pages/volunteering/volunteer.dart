import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifehack22/shared/bar_widgets.dart';
import 'package:lifehack22/shared/constants.dart';
import 'package:provider/provider.dart';

import '../../models/event.dart';
import '../../services/event_database.dart';
import '../../shared/event_list.dart';

class Volunteer extends StatefulWidget {
  const Volunteer({Key? key}) : super(key: key);

  @override
  State<Volunteer> createState() => _VolunteerState();
}

class _VolunteerState extends State<Volunteer> {

  final List<String> _regions = ['North', 'South', 'East', 'West', 'Central'];
  final List<String> _types = ['Cooking', 'Packing', 'Delivery', 'Interaction', 'Logistics', 'Others'];
  final List<String> _communityGroups = ['Elderly', 'Youths', 'Disabled', 'Migrants', 'Low-Income', 'Others'];

  final int _position = 2;
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _region;
  String? _type;
  String? _community;

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
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  color: darkestPink,
                  height: 75,
                  child: Text(
                    'Upcoming Events',
                     style: helveticaTextStyle.copyWith(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget> [
              horizontalGapBox,
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.only(top: 5.0, bottom: 15.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: darkestPink, width: 1.0),
                  color: darkestPinkOpacity10,
                ),
                child: Column(
                  children: <Widget> [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget> [
                          const Icon(
                            Icons.filter_alt,
                            color: darkestPink,
                            size: 40.0,
                          ),
                          verticalGapBox,
                          Text(
                            'Filter',
                            style: helveticaTextStyle.copyWith(fontSize: 28.0, fontWeight: FontWeight.bold, color: darkestPink),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: Column(
                        children: <Widget> [
                          DropdownButtonFormField2( // region
                            decoration: formFieldDeco.copyWith(
                              hintText: 'Region',
                              hintStyle: helveticaTextStyle.copyWith(fontSize: 18.0, color: darkestPink),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down_sharp),
                            iconEnabledColor: darkestPink,
                            iconSize: 30,
                            buttonHeight: 27.0,
                            dropdownDecoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              color: Colors.white,
                            ),
                            dropdownElevation: 0,
                            dropdownMaxHeight: 180.0,
                            itemHeight: 35.0,
                            items: _regions.map((region) {
                              return DropdownMenuItem<String>(
                                value: region,
                                child: SizedBox(
                                  width: 145.0,
                                  height: 27.0,
                                  child: Text(
                                    region,
                                    style: helveticaTextStyle.copyWith(color: darkestPink, fontSize: 18.0),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) =>
                                setState(() {
                                  _region = value as String;
                                }),
                            value: _region,
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a region.';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 5.0),
                          DropdownButtonFormField2( // type
                            decoration: formFieldDeco.copyWith(
                              hintText: 'Type of Event',
                              hintStyle: helveticaTextStyle.copyWith(fontSize: 18.0, color: darkestPink),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down_sharp),
                            iconEnabledColor: darkestPink,
                            iconSize: 30,
                            buttonHeight: 27.0,
                            dropdownDecoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              color: Colors.white,
                            ),
                            dropdownElevation: 0,
                            dropdownMaxHeight: 220.0,
                            itemHeight: 35.0,
                            items: _types.map((type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: SizedBox(
                                  width: 145.0,
                                  height: 27.0,
                                  child: Text(
                                    type,
                                    style: helveticaTextStyle.copyWith(color: darkestPink, fontSize: 18.0),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) =>
                                setState(() {
                                  _type = value as String;
                                }),
                            value: _type,
                            validator: (value) {
                              if (value == null) {
                                return 'Please select an event type.';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 5.0),
                          DropdownButtonFormField2( // cause
                            decoration: formFieldDeco.copyWith(
                              hintText: 'Community',
                              hintStyle: helveticaTextStyle.copyWith(fontSize: 18.0, color: darkestPink),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down_sharp),
                            iconEnabledColor: darkestPink,
                            iconSize: 30,
                            buttonHeight: 27.0,
                            dropdownDecoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              color: Colors.white,
                            ),
                            dropdownElevation: 0,
                            dropdownMaxHeight: 220.0,
                            itemHeight: 35.0,
                            items: _communityGroups.map((group) {
                              return DropdownMenuItem<String>(
                                value: group,
                                child: SizedBox(
                                  width: 145.0,
                                  height: 27.0,
                                  child: Text(
                                    group,
                                    style: helveticaTextStyle.copyWith(color: darkestPink, fontSize: 18.0),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) =>
                                setState(() {
                                  _community = value as String;
                                }),
                            value: _community,
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a cause your event supports.';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              horizontalGapBox,
              Expanded(
                child: Column(
                  children: <Widget> [
                    StreamProvider<List<Event>>.value(
                      value: EventDatabase().volunteeringEventsStream(_region, _type, _community),
                      initialData: const [],
                      child: Flexible(
                          child: EventList(username: uid)
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: navBarGrey,
          child: navigationBar(context, _position),
        )
    );
  }
}