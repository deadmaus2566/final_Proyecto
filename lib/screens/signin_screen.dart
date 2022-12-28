import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:final_sinup_and_singout_and_register/widget/sign_up_option.dart';
import 'package:final_sinup_and_singout_and_register/screens/home_scree.dart';
import 'package:final_sinup_and_singout_and_register/screens/reset_password.dart';
import 'package:final_sinup_and_singout_and_register/widget/widgets_reusables.dart';
import 'package:final_sinup_and_singout_and_register/widget/widgets_reusables2.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  void loginFirebase(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text)
          .then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(
              screen: 2,
            ),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Ningún usuario encontrado para ese correo electrónico.",
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Se proporcionó una contraseña incorrecta para ese usuario.",
            ),
          ),
        );
      }
    }
  }

  void loginGoogle(BuildContext context) async {
    FirebaseAuth objFirebaseAuth = FirebaseAuth.instance;
    GoogleSignIn objGoogleSignIn = GoogleSignIn();
    GoogleSignInAccount? objGoogleSignInAccount =
        await objGoogleSignIn.signIn();

    if (objGoogleSignInAccount != null) {
      GoogleSignInAuthentication objGoogleSignInAuthentication =
          await objGoogleSignInAccount.authentication;

      AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: objGoogleSignInAuthentication.accessToken,
        idToken: objGoogleSignInAuthentication.idToken,
      );

      try {
        await objFirebaseAuth
            .signInWithCredential(authCredential)
            .then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(
                screen: 1,
              ),
            ),
          );
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-disabled') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Usuario deshabilitado.",
              ),
            ),
          );
        } else if (e.code == 'operation-not-allowed') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "El usuario cancelo el proceso.",
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 213, 84, 9),
              Color.fromARGB(255, 210, 18, 18),
              Color.fromARGB(255, 168, 44, 10),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 50,
            ),
            child: Column(
              children: <Widget>[
                logoWidget("assets/logo1.png"),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputText(
                        text: "Correo electrónico",
                        icon: Icons.email_outlined,
                        isPasswordType: false,
                        controller: _emailTextController,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains("@")) {
                            return "Ingrese un correo electrónico valido";
                          }

                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return 'El valor ingresado no es un correo electrónico';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InputText(
                        text: "Contraseña",
                        icon: Icons.lock_outline,
                        isPasswordType: true,
                        controller: _passwordTextController,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return "Ingrese una contraseña valida.";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const _ForgetPassword(),
                FireBaseUIButton(
                  context: context,
                  title: "Ingresar",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("procesando data"),
                        ),
                      );

                      loginFirebase(context);
                    }
                  },
                ),
                const SignUpOption(
                  msj: "¿No tienes cuenta?",
                  action: " Registrate",
                ),
                const SizedBox(
                  height: 50,
                ),
                FireBaseUIButton(
                  context: context,
                  title: "Iniciar Sesión con Google",
                  onTap: () {
                    loginGoogle(context);
                  },
                  isIcon: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ForgetPassword extends StatelessWidget {
  const _ForgetPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "¿Has olvidado tu contraseña?",
          style: TextStyle(
            color: Colors.white70,
          ),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPassword(),
          ),
        ),
      ),
    );
  }
}
