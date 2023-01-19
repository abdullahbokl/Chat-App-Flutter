import 'package:chatapp/constants.dart';
import 'package:flutter/material.dart';

Column logo() {
  return Column(
    children: [
      Image.asset(kLogoPath),
      const Text(
        'Scholar Chat',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: 'pacifico',
          color: Colors.white,
        ),
      ),
    ],
  );
}

Row haveAccountOrNot({ required bool is_login, required VoidCallback onPressed}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        is_login ? 'don\'t have an account?' : 'already have an account?',
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      TextButton(
          onPressed: onPressed,
          child: Text(
            is_login ? 'Register' : 'Sign In',
            style: const TextStyle(
              color: Colors.white,
            ),
          )),
    ],
  );
}


void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}