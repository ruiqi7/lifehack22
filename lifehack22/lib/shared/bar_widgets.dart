import 'package:flutter/material.dart';
import 'package:lifehack22/pages/organise/organise.dart';
import 'package:lifehack22/pages/volunteering/volunteer.dart';
import 'package:lifehack22/services/user_database.dart';
import 'package:lifehack22/shared/constants.dart';
import 'package:page_transition/page_transition.dart';

import '../pages/home/Home.dart';
import '../pages/profile/profile.dart';

navigationBar(context, position, uid) => SafeArea(
  key: const Key('NavigationBar'),
  child: Row(
      children: <Widget> [
        Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: navBarGrey,
              height: 80.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget> [
                  // Home
                  Container(
                    width: 85,
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: position == 1 ? const Color.fromRGBO(178, 0, 86, 0.4) : transparent,
                    ),
                    child: TextButton(
                      key: const Key('HomeTab'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          Icon(
                            Icons.home,
                            color: position == 1 ? darkestPink : navBarObjGrey,
                            size: 33,
                          ),
                          Text(
                            'Home',
                            style: helveticaTextStyle.copyWith(fontSize: 15, color: position == 1 ? darkestPink : navBarObjGrey, letterSpacing: 1.0),
                          )
                        ],
                      ),
                      onPressed: () {
                        if (position > 1) {
                          Navigator.push(
                              context,
                              PageTransition(child: const Home(), type: PageTransitionType.leftToRight)
                          );
                        } else if (position < 1) {
                          Navigator.push(
                              context,
                              PageTransition(child: const Home(), type: PageTransitionType.rightToLeft)
                          );
                        }
                      },
                    ),
                  ),
                  // Volunteer
                  Container(
                    width: 90,
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: position == 2 ? const Color.fromRGBO(178, 0, 86, 0.4) : transparent,
                    ),
                    child: TextButton(
                      key: const Key('VolunteerTab'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          Icon(
                            Icons.handshake_rounded,
                            color: position == 2 ? darkestPink : navBarObjGrey,
                            size: 33,
                          ),
                          Text(
                            'Volunteer',
                            style: helveticaTextStyle.copyWith(fontSize: 15, color: position == 2 ? darkestPink : navBarObjGrey, letterSpacing: 1.0),
                          )
                        ],
                      ),
                      onPressed: () {
                        if (position > 2) {
                          Navigator.push(
                              context,
                              PageTransition(child: const Volunteer(), type: PageTransitionType.leftToRight)
                          );
                        } else if (position < 2) {
                          Navigator.push(
                              context,
                              PageTransition(child: const Volunteer(), type: PageTransitionType.rightToLeft)
                          );
                        }
                      },
                    ),
                  ),
                  // Organise
                  Container(
                    width: 85,
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: position == 3 ? const Color.fromRGBO(178, 0, 86, 0.4) : transparent,
                    ),
                    child: TextButton(
                      key: const Key('OrganiseTab'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          Icon(
                            Icons.dashboard_customize_outlined,
                            color: position == 3 ? darkestPink : navBarObjGrey,
                            size: 33,
                          ),
                          Text(
                            'Organise',
                            style: helveticaTextStyle.copyWith(fontSize: 15, color: position == 3 ? darkestPink : navBarObjGrey, letterSpacing: 1.0),
                          )
                        ],
                      ),
                      onPressed: () {
                        if (position > 3) {
                          Navigator.push(
                              context,
                              PageTransition(child: const Organise(), type: PageTransitionType.leftToRight)
                          );
                        } else if (position < 3) {
                          Navigator.push(
                              context,
                              PageTransition(child: const Organise(), type: PageTransitionType.rightToLeft)
                          );
                        }
                      },
                    ),
                  ),
                  // Profile
                  Container(
                    width: 85,
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: position == 4 ? const Color.fromRGBO(178, 0, 86, 0.4) : transparent,
                    ),
                    child: TextButton(
                      key: const Key('ProfileTab'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          Icon(
                            Icons.person,
                            color: position == 4 ? darkestPink : navBarObjGrey,
                            size: 33,
                          ),
                          Text(
                            'Profile',
                            style: helveticaTextStyle.copyWith(fontSize: 15, color: position == 4 ? darkestPink : navBarObjGrey, letterSpacing: 1.0),
                          )
                        ],
                      ),
                      onPressed: () async {
                        DatabaseService dbs = DatabaseService(uid: uid);
                        String name = await dbs.getName();
                        String email = await dbs.getEmail();
                        String phone = await dbs.getPhone();

                        if (position > 4) {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: Profile(name: name, email: email, phone: phone),
                                  type: PageTransitionType.leftToRight
                              )
                          );
                        } else if (position < 4) {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: Profile(name: name, email: email, phone: phone),
                                  type: PageTransitionType.rightToLeft
                              )
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
        ),
      ]
  ),
);