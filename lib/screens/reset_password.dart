import 'package:final_sinup_and_singout_and_register/widget/widgets_reusables.dart';
import 'package:final_sinup_and_singout_and_register/widget/widgets_reusables2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 213, 84, 9),
            Color.fromARGB(255, 210, 18, 18),
            Color.fromARGB(255, 168, 44, 10),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    child: InputText(
                      text: "Email",
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
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FireBaseUIButton(
                  context: context,
                  title: "Reset Password",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Processing Data")));
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(
                              email: _emailTextController.text)
                          .then((value) => Navigator.of(context).pop());
                    }
                  },
                ),
              ],
            ),
          ))),
    );
  }
}
