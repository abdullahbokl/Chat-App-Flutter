import 'package:chatapp/constants.dart';
import 'package:chatapp/screens/widgets/bubblechat_widget.dart';
import 'package:flutter/material.dart';

class BubbleChatWidget extends StatelessWidget {

  String message;
  bool is_me;

  BubbleChatWidget({required this.message, required this.is_me});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: is_me ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        decoration: BoxDecoration(
          color: is_me ? kPrimaryColor : kSecondColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomRight: is_me ? Radius.circular(24) : Radius.zero ,
            bottomLeft: is_me ? Radius.zero : Radius.circular(24) ,
          ),
        ),
        child: Text(message, style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500
        ),),
      ),
    );
  }
}
