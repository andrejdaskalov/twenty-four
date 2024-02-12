import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twenty_four/common_components/text_input.dart';
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
                TFPasswordInput(
                    controller: passwordController, label: "Password"),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      tryLogin(emailController.text, passwordController.text,
                          () {
                        GoRouter.of(context).go("/");
                      }, (error) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(error),
                        ));
                      });
                    },
                    child: const Text("Login"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterView()));
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

void tryLogin(
  String email,
  String password,
  void Function() onSuccess,
  void Function(String error) onError,
) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    )
        .then((value) {
      onSuccess();
    }).onError((error, stackTrace) {
      onError(error.toString());
    });
  } on FirebaseAuthException catch (e) {
    onError(e.message ?? "An error occurred");
  }
}
