import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  CustomTextFormField({this.hint, this.onChanged, this.validator, this.obscureText = false});

  String? hint;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: validator,
      onChanged: onChanged,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        )
      ),
    );
  }
}
