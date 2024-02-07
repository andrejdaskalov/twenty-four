import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../common_components/text_input.dart';
import '/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  void tryRegister(String email, String password, String repeatPassword,
      Function(String) showSnackbar, void Function() goBack) {
    if (password != repeatPassword) {
      showSnackbar("Passwords do not match");
      return;
    }
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value)  {
          showSnackbar("Successfully registered");
          goBack();
        })
        .catchError((error) => showSnackbar(error.message));
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController repeatPasswordController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TFTextInput(
              controller: emailController,
              label: "Email",
            ),
            TFPasswordInput(controller: passwordController, label: "Password"),
            TFPasswordInput(controller: repeatPasswordController, label: "Repeat Password"),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  tryRegister(emailController.text, passwordController.text,
                      repeatPasswordController.text, (String message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                      ),
                    );
                  }, () {
                    Navigator.pop(context);
                  });
                },
                child: const Text("Register"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
