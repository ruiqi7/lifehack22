import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lifehack22/services/authentication.dart';
import 'package:lifehack22/shared/constants.dart';
import 'package:lifehack22/shared/custom_text_widgets.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final Authentication _authenticate = Authentication();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // value of the form field
  String _email = '';

  // to indicate if password reset email was sent
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            Expanded(
              flex: 3,
              child: Container(
                color: darkestPink,
                padding: const EdgeInsets.only(top: 50.0),
                child: const SafeArea(child: HelveticaHeader(text: 'Reset Password')),
              ),
            ),
            horizontalGapBox,
            horizontalGapBox,
            Expanded(
              flex: 7,
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
                          )
                        ],
                      ),
                    ),
                  ),
                  horizontalGapBox,
                  Container(
                    width: 210.0,
                    height: 90.0,
                    decoration: largeRadiusRoundedBox1,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(5.0),
                        primary: Colors.white,
                        textStyle: helveticaTextStyle.copyWith(fontSize: 27.5),
                      ),
                      child: const AutoSizeText(
                        'Send Password Reset Email',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String status = await _authenticate.customResetPassword(_email);
                          setState(() => _message = status);
                        }
                      },
                    ),
                  ),
                  horizontalGapBox,
                  backButton(context),
                  const SizedBox(height: 10.0),
                  AutoSizeText(
                    _message,
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