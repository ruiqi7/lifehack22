import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lifehack22/shared/constants.dart';
import 'package:lifehack22/pages/menu/sign_in.dart';
import 'package:lifehack22/pages/menu/sign_up.dart';
import 'package:page_transition/page_transition.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  button(text, function) => Container(
    width: 300.0,
    height: 80.0,
    decoration: smallRadiusRoundedBox1,
    child: TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
      ),
      onPressed: function,
      child: AutoSizeText(
        text,
        style: helveticaTextStyle.copyWith(fontSize: 40.0, fontWeight: FontWeight.bold),
        maxLines: 1,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              Container(
                color: darkestPink,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SafeArea(
                  child: Column(
                    children: <Widget> [
                      const SizedBox(height: 20.0),
                      Text('Stand Together', style: helveticaTextStyle.copyWith(fontSize: 60, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      horizontalGapBox,
                      const Icon(
                        Icons.handshake,
                        color: Colors.white,
                        size: 100.0,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Container(
                color: Colors.white,
                child: Column(
                    children: <Widget> [
                      button(
                        'Sign In',
                        () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: const SignIn(),
                                  type: PageTransitionType.rightToLeftPop, childCurrent: this
                              )
                          );
                        },
                      ),
                      horizontalGapBox,
                      button(
                        'Sign Up',
                        () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: const SignUp(),
                                  type: PageTransitionType.rightToLeftPop, childCurrent: this
                              )
                          );
                        },
                      ),
                    ],
                ),
              ),
            ],
          )
      ),
    );
  }
}