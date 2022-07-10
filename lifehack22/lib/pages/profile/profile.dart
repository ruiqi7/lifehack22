import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifehack22/pages/profile/past_events.dart';
import 'package:lifehack22/services/user_database.dart';
import 'package:lifehack22/shared/bar_widgets.dart';
import 'package:lifehack22/shared/constants.dart';
import 'package:page_transition/page_transition.dart';

class Profile extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  const Profile({Key? key, required this.name, required this.email, required this.phone}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final int _position = 4;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // values of the form fields
  String _name = '';
  String _phone = '';

  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            horizontalGapBox,
            Container(
              width: 300.0,
              height: 385.0,
              padding: const EdgeInsets.all(17.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: darkestPinkOpacity10,
              ),
              child: Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      horizontalGapBox,
                      horizontalGapBox,
                      AutoSizeText(
                        'Name',
                        style: helveticaTextStyle.copyWith(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
                        maxLines: 1,
                      ),
                      horizontalGapBox,
                      TextFormField( // name
                        enabled: widget.name.isEmpty,
                        initialValue: widget.name,
                        decoration: formFieldDeco.copyWith(hintText: 'Name'),
                        style: formInputTextStyle.copyWith(fontSize: 18.0),
                        validator: (value) =>
                        value!.trim().isEmpty
                            ? 'Enter your name'
                            : null,
                        onChanged: (value) {
                          setState(() => _name = value.trim());
                        },
                      ),
                      horizontalGapBox,
                      horizontalGapBox,
                      AutoSizeText(
                        'Email',
                        style: helveticaTextStyle.copyWith(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
                        maxLines: 1,
                      ),
                      horizontalGapBox,
                      TextFormField( // email
                        enabled: false,
                        initialValue: widget.email,
                        decoration: formFieldDeco,
                        style: formInputTextStyle.copyWith(fontSize: 18.0),
                        validator: (value) =>
                        value!.trim().isEmpty
                            ? 'Enter your email'
                            : null,
                      ),
                      horizontalGapBox,
                      horizontalGapBox,
                      AutoSizeText(
                        'Phone Number',
                        style: helveticaTextStyle.copyWith(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
                        maxLines: 1,
                      ),
                      horizontalGapBox,
                      TextFormField( // phone
                        enabled: widget.phone.isEmpty,
                        initialValue: widget.phone,
                        decoration: formFieldDeco.copyWith(hintText: 'Phone Number'),
                        style: formInputTextStyle.copyWith(fontSize: 18.0),
                        validator: (value) =>
                        value!.trim().isEmpty
                            ? 'Enter your phone number'
                            : int.tryParse(value) == null || value.trim().length != 8 || !(value.startsWith('8') || value.startsWith('9'))
                            ? 'Enter a valid local phone number'
                            : null,
                        onChanged: (value) {
                          setState(() => _phone = value.trim());
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            horizontalGapBox,
            Center(
              child: Container(
                width: 160.0,
                height: 55.0,
                decoration: largeRadiusRoundedBox1,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(5.0),
                    primary: Colors.white,
                    textStyle: helveticaTextStyle.copyWith(fontSize: 27.5, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Save'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      DatabaseService(uid: uid).updateProfile(_name, _phone);

                      setState(() {
                        _message = 'Saved!';
                      });
                      Future.delayed(const Duration(seconds: 2), () {
                        if (mounted) {
                          setState(() => _message = '');
                        }
                      });
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              _message,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
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
          child: navigationBar(context, _position, uid),
        )
    );
  }
}
