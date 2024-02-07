import 'package:flutter/material.dart';

class _TFTextInput extends StatelessWidget {
  const _TFTextInput(
      {Key? key,
      required this.controller,
      required this.label,
      this.obscureText = false,
      this.enableSuggestions = true,
      this.autocorrect = true})
      : super(key: key);

  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelAlignment: FloatingLabelAlignment.center,
      ),
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
    );
  }
}

class TFTextInput extends _TFTextInput {
  const TFTextInput({Key? key, required controller, required label})
      : super(key: key, controller: controller, label: label);
}

class TFPasswordInput extends _TFTextInput {
  const TFPasswordInput({Key? key, required controller, required label})
      : super(
            key: key,
            controller: controller,
            label: label,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false);
}
