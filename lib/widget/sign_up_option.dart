import 'package:flutter/material.dart';
import 'package:final_sinup_and_singout_and_register/screens/signup_screen.dart';

class SignUpOption extends StatelessWidget {
  final String msj;
  final String action;

  const SignUpOption({
    Key? key,
    required this.msj,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          msj,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ),
            );
          },
          child: Text(
            action,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
