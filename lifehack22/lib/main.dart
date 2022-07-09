import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // Root of App
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final double buttonWidth = 300;
  final double buttonHeight = 80;
  final SizedBox gapBox = const SizedBox(height: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkestPink,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              const Text('Stand Together'),
              const SizedBox(height: 45),
              Container(
                width: buttonWidth,
                height: buttonHeight,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromRGBO(255, 255, 255, 0.15),
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(
                        fontSize: 33.0,
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontFamily: 'Chewy'

                    ),
                  ),
                  child: const Text('Welcome Back!'),
                  onPressed: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignInPage()),
                    ); */
                  },
                ),
              ),
              gapBox,
              Container(
                width: buttonWidth,
                height: buttonHeight,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromRGBO(255, 255, 255, 0.15)
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(
                        fontSize: 33.0,
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontFamily: 'Chewy'

                    ),
                  ),
                  child: const Text('I\'m new here!'),
                  onPressed: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpPage()),
                    ); */
                  },
                ),
              ),
            ],
          )
      ),
    );
  }
}