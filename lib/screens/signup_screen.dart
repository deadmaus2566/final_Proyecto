import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:final_sinup_and_singout_and_register/screens/home_scree.dart';
import 'package:final_sinup_and_singout_and_register/widget/widgets_reusables.dart';
import 'package:final_sinup_and_singout_and_register/widget/widgets_reusables2.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(
            "Registrarse",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
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
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputText(
                        text: "Nombre de usuario",
                        icon: Icons.person_outline,
                        isPasswordType: false,
                        controller: _userNameTextController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ingrese su nombre";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
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
                        validator: (String? value) {
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
                  height: 20,
                ),
                FireBaseUIButton(
                  title: "Registrarse",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Procesando data..."),
                        ),
                      );
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(
                              screen: 1,
                            ),
                          ),
                        );
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
