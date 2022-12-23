import 'package:final_sinup_and_singout_and_register/screens/home_scree.dart';
import 'package:final_sinup_and_singout_and_register/widget/widgets_reusables.dart';
import 'package:final_sinup_and_singout_and_register/widget/widgets_reusables2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
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
                  child: Column(
                    children: [
                      InputText(
                        text: "User Name",
                        icon: Icons.person_outline,
                        isPasswordType: false,
                        controller: _userNameTextController,
                        validator: (String? value) {
                          if (value!.isEmpty || value.length < 6) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please Enter Your Name")));
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
                InputText(
                  text: "Email",
                  icon: Icons.email_outlined,
                  isPasswordType: false,
                  controller: _emailTextController,
                  validator: (String? value) {
                    if (value!.isEmpty || !value.contains("@")) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Enter Your Email")));
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                InputText(
                  text: "Password",
                  icon: Icons.lock_outline,
                  isPasswordType: true,
                  controller: _passwordTextController,
                  validator: (String? value) {
                    if (value!.isEmpty || value.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Enter Your Password")));
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                FireBaseUIButton(
                  title: "Sign Up",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Processing Data")));
                    }
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      print("Created New Account");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  },
                )
              ],
            ),
          ))),
    );
  }
}
