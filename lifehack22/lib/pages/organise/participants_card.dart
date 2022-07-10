import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lifehack22/shared/constants.dart';

import '../../models/app_user.dart';

class ParticipantsCard extends StatelessWidget {
  final AppUser appUser;
  final int position;
  const ParticipantsCard({
    Key? key,
    required this.appUser,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(width: 15),
                  //insert the three text widgets
                  SizedBox(
                    width: 40,
                    child: Text(
                      position.toString(),
                      style: helveticaTextStyle.copyWith(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: 150,
                    child: AutoSizeText(
                      appUser.name,
                      style: helveticaTextStyle.copyWith(color: Colors.black, fontSize: 20),
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: 150,
                    child: AutoSizeText(
                      appUser.phone,
                      style: helveticaTextStyle.copyWith(color: Colors.black, fontSize: 20),
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 250,
                    child: Text(
                      appUser.email,
                      style: helveticaTextStyle.copyWith(color: Colors.black, fontSize: 20),
                      maxLines: 1,
                    ),
                  ),
                  verticalGapBox,
                ],
              ),
            ],
          ),
        ),
        noHeightHorizontalDivider
      ],
    );
  }
}
