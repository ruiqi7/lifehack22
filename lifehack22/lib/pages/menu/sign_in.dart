import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lifehack22/models/custom_user.dart';
import 'package:lifehack22/pages/loading.dart';
import 'package:lifehack22/pages/menu/reset_password.dart';
import 'package:lifehack22/services/authentication.dart';
import 'package:lifehack22/shared/constants.dart';
import 'package:lifehack22/shared/custom_text_widgets.dart';
import 'package:page_transition/page_transition.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final Authentication _authenticate = Authentication();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // values of the form fields
  String _email = '';
  String _password = '';

  // invalid sign in error message
  String _error = '';

  // whether to display loading screen
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading ? const Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: darkestPink,
                padding: const EdgeInsets.only(top: 30.0),
                child: const SafeArea(child: HelveticaHeader(text: 'Sign In')),
              ),
            ),
            horizontalGapBox,
            horizontalGapBox,
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
                            validator: (value) =>
                            value!.trim().isEmpty
                                ? 'Enter your email'
                                : null,
                            onChanged: (value) {
                              setState(() => _email = value.trim());
                            },
                          ),
                          horizontalGapBox,
                          TextFormField( // password
                            decoration: formFieldDeco.copyWith(hintText: 'Password'),
                            style: formInputTextStyle.copyWith(fontSize: 18.0),
                            obscureText: true,
                            validator: (value) =>
                            value!.trim().isEmpty
                                ? 'Enter your password'
                                : null,
                            onChanged: (value) {
                              setState(() => _password = value.trim());
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  horizontalGapBox,
                  Container(
                    width: 160.0,
                    height: 55.0,
                    decoration: largeRadiusRoundedBox1,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(5.0),
                        primary: Colors.white,
                        textStyle: helveticaTextStyle.copyWith(fontSize: 27.5),
                      ),
                      child: const Text('Login'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          CustomUser? result = await _authenticate.customSignIn(_email, _password);
                          if (result == null) {
                            setState(() => _error = 'Invalid email and / or password.');
                          } else {
                            setState(() => _loading = true);
                            Navigator.pop(context);
                          }
                        }
                      },
                    ),
                  ),
                  horizontalGapBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 200.0,
                        height: 40.0,
                        decoration: largeRadiusRoundedBox1,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5.0),
                            primary: Colors.white,
                            textStyle: helveticaTextStyle.copyWith(fontSize: 20.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: const ResetPassword(),
                                    type: PageTransitionType.rightToLeftPop,
                                    childCurrent: widget
                                )
                            );
                          },
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                      const SizedBox(width: 15.0),
                      backButton(context)
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    _error,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12.0,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}