import 'package:flutter/material.dart';

TextFormField buildTextField({
  required String label,
  required TextEditingController controller,
  Widget? icon,
  context,
  int? maxLines,
  bool? isObsecture,
}) {
  return TextFormField(
    obscureText: isObsecture ?? false,
    controller: controller,
    maxLines: maxLines ?? 1,
    decoration: InputDecoration(
      icon: icon ?? const SizedBox(width: 24),
      labelText: label,
    ),
  );
}
