import 'package:chatapp/constants.dart';
import 'package:flutter/material.dart';

class MessageModel {

  final String messageContent;
  final String id;
  MessageModel({required this.messageContent, required this.id});

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(messageContent: jsonData[kMessageContent], id: jsonData['id']);
  }

}

