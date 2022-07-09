import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lifehack22/models/custom_user.dart';
import 'package:lifehack22/pages/authentication_wrapper.dart';
import 'package:lifehack22/services/authentication.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    initialRoute: '/',
    home: App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // Root of App
  @override
  Widget build(BuildContext context) {
    //Authentication().customSignOut();
    return StreamProvider<CustomUser?>.value(
      value: Authentication().usersStream,
      initialData: null,
      child: const Scaffold(
        body: AuthenticationWrapper(),
      ),
    );
  }
}