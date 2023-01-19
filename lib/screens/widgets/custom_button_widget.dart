import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {

  String label;
  VoidCallback onPressed;

  // CustomButtonWidget(this.label, this.onPressed);
  CustomButtonWidget({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
