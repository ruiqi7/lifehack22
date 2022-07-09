import 'package:flutter/material.dart';
import 'package:lifehack22/models/custom_user.dart';
import 'package:lifehack22/pages/menu/main_menu.dart';
import 'package:lifehack22/pages/menu/verify_email.dart';
import 'package:provider/provider.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomUser? customUser = Provider.of<CustomUser?>(context);

    if (customUser == null) { // user is signed out
      return const MainMenu();
    } else { // user is signed in
      return const VerifyEmail();
    }
  }
}