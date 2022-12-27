import 'package:final_sinup_and_singout_and_register/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Create_user extends StatefulWidget {
  const Create_user({Key? key}) : super(key: key);

  @override
  _Create_userState createState() => _Create_userState();
}

class _Create_userState extends State<Create_user> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuario creado"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Logout"),
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              print("Signed Out");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            });
          },
        ),
      ),
    );
  }
}
