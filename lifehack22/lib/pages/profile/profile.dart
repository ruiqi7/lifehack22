import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifehack22/pages/profile/past_events.dart';
import 'package:lifehack22/shared/bar_widgets.dart';
import 'package:lifehack22/shared/constants.dart';
import 'package:page_transition/page_transition.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final int _position = 4;
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
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    'Profile',
                    style: helveticaTextStyle.copyWith(fontSize: 36, fontWeight: FontWeight.bold),
                    maxLines: 1,
                  )
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: <Widget> [
            // add the edit the profile stuff here
            // view your past events
            horizontalGapBox,
            Center(
              child: Container(
                decoration: largeRadiusRoundedBox1,
                padding: const EdgeInsets.all(5.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                          child: PastEvents(uid: uid),
                          type: PageTransitionType.bottomToTop,
                        )
                    );
                  },
                  child: Text(
                    'View Your Past Events',
                    style: helveticaTextStyle.copyWith(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                )
              ),
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
