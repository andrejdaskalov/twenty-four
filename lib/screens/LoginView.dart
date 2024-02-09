import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:twenty_four/common_components/text_input.dart';
import '/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'RegisterView.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TFTextInput(
                  controller: emailController,
                  label: "Email",
                ),
                TFPasswordInput(controller: passwordController, label: "Password"),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      tryLogin(emailController.text, passwordController.text,
                              (String message) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message),
                              ),
                            );
                          });
                    },
                    child: const Text("Login"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => RegisterView()));
                    },
                    child: const Text("Not registered? Register here."),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void tryLogin(String email, String password,
    void Function(String test) showSnackbar) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'invalid-credential') {
      showSnackbar("No user found for that email.");
    } else {
      showSnackbar(e.message ?? "An error occurred");
    }
  }
}
