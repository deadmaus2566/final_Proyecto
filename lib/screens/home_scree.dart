import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:final_sinup_and_singout_and_register/screens/signin_screen.dart';

class HomeScreen extends StatelessWidget {
  final int screen;

  const HomeScreen({
    Key? key,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 252, 39, 7),
        title: const Text(
          'Home',
        ),
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              FirebaseAuth.instance.signOut().then(
                (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    ),
                  );
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.exit_to_app,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Text(
          screen == 2
              ? "!Bienvenido! \n Te acabas de loguear"
              : "!Bienvenido! \n Te acabas de registrar",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
