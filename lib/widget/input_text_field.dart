import 'package:flutter/material.dart';

TextFormField InputTextField(TextEditingController controller, String labelString) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelString,
    ),
  );
}