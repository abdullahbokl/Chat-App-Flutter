import 'package:chatapp/screens/components/components.dart';
import 'package:chatapp/screens/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireBaseServices {
  static Future<void> createUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      showSnackBar(context, 'Success');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          showSnackBar(context, 'The password provided is too weak.');
          break;
        case 'email-already-in-use':
          showSnackBar(context, 'The account already exists for that email.');
          break;
        case 'invalid-email':
          showSnackBar(context, 'Not a valid email address.');
          break;
        default:
          showSnackBar(context, 'Unknown error.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pushReplacementNamed(ChatPage.route, arguments: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, 'Wrong password provided for that user.');
      }
    }
  }


  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

}
