import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifehack22/pages/home/home.dart';
import 'package:lifehack22/services/authentication.dart';
import 'package:lifehack22/services/user_database.dart';
import 'package:lifehack22/shared/constants.dart';
import 'package:lifehack22/shared/custom_text_widgets.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool _verified = false;
  Timer? _timer;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _verified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!_verified) {
      sendVerificationEmail();

      // periodically check if the email has been verified
      _timer = Timer.periodic(
        const Duration(seconds: 3),
            (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      return 'Email sent!';
    } catch (exception) {
      return 'Please try again later.';
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      _verified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (_verified) {
      _timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _verified ? const Home() : Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            Expanded(
              flex: 1,
              child: Container(
                color: darkestPink,
                padding: const EdgeInsets.only(top: 55.0),
                child: const SafeArea(child: HelveticaHeader(text: 'Verify Email')),
              ),
            ),
            horizontalGapBox,
            horizontalGapBox,
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Container(
                      width: 300.0,
                      height: 100.0,
                      padding: const EdgeInsets.all(17.0),
                      decoration: smallRadiusRoundedBox1,
                      child: AutoSizeText(
                        'A verification email has been sent to your email!',
                        textAlign: TextAlign.center,
                        style: helveticaTextStyle.copyWith(fontSize: 25.0),
                        maxLines: 3,
                      )
                  ),
                  const SizedBox(height: 60.0),
                  Container(
                    width: 210,
                    height: 60,
                    decoration: largeRadiusRoundedBox1,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(5.0),
                        primary: Colors.white,
                        textStyle: helveticaTextStyle.copyWith(fontSize: 23.0),
                      ),
                      child: const AutoSizeText(
                        'Resend Email',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      onPressed: () async {
                        String result = await sendVerificationEmail();
                        setState(() => _message = result);
                        await Future.delayed(const Duration(seconds: 1));
                        if (mounted) {
                          setState(() => _message = '');
                        }
                      },
                    ),
                  ),
                  horizontalGapBox,
                  Container(
                    width: 100,
                    height: 40,
                    decoration: largeRadiusRoundedBox1,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(5.0),
                        primary: Colors.white,
                        textStyle: helveticaTextStyle.copyWith(fontSize: 20.0),
                      ),
                      onPressed: () async {
                        await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).deleteUserDocument();
                        await FirebaseAuth.instance.currentUser!.delete();
                        await Authentication().customSignOut();
                      },
                      child: const AutoSizeText('Cancel', maxLines: 1),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    _message,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12.0,
                    ),
                  )
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}