import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lifehack22/pages/loading.dart';
import 'package:lifehack22/services/authentication.dart';
import 'package:lifehack22/shared/constants.dart';
import 'package:lifehack22/shared/custom_text_widgets.dart';
import 'package:page_transition/page_transition.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final Authentication _authenticate = Authentication();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // values of the form fields
  String _email = '';
  String _password = '';

  // invalid sign up error message
  String _error = '';

  // whether to display loading screen
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading ? const Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget> [
              Expanded(
                flex: 1,
                child: Container(
                  color: darkestPink,
                  padding: const EdgeInsets.only(top: 50.0),
                  child: const HelveticaHeader(text: 'Sign Up'),
                ),
              ),
              gapBox,
              gapBox,
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Column(
                          children: <Widget>[
                            TextFormField( // email
                              decoration: formFieldDeco.copyWith(hintText: 'Email'),
                              style: formInputTextStyle.copyWith(fontSize: 18.0),
                              validator: (value) => value!.trim().isEmpty ? 'Enter your email' : null,
                              onChanged: (value) {
                                setState(() => _email = value.trim());
                              },
                            ),
                            gapBox,
                            TextFormField( // password
                              decoration: formFieldDeco.copyWith(hintText: 'Password'),
                              style: formInputTextStyle.copyWith(fontSize: 18.0),
                              obscureText: true,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Enter your password';
                                } else if (value.trim().length < 6) {
                                  return 'Enter at least 6 characters';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                setState(() => _password = value.trim());
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    gapBox,
                    gapBox,
                    Container(
                      width: 160,
                      height: 55,
                      decoration: largeRadiusRoundedBox,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(5.0),
                          primary: Colors.white,
                          textStyle: helveticaTextStyle.copyWith(fontSize: 27.5),
                        ),
                        child: const AutoSizeText('Sign Up!', maxLines: 1),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String message = await _authenticate.customSignUp(_email, _password);
                            if (message.isNotEmpty) {
                              setState(() => _error = message);
                            } else {
                              setState(() => _loading = true);
                              Navigator.pop(context);
                            }
                          }
                        },
                      ),
                    ),
                    gapBox,
                    backButton(context),
                    const SizedBox(height: 10.0),
                    AutoSizeText(
                      _error,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                      ),
                      maxLines: 1,
                    )
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}