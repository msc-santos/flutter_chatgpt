import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/models/chat_message.dart';
import 'package:flutter_chatgpt/models/chat_user.dart';
import 'package:flutter_chatgpt/services/chat_gpt_service.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messagesStream();
  Future<void> callWithChatGpt(String question, BuildContext context);
  Future<ChatMessage?> send(String text, ChatUser user);

  factory ChatService() {
    return ChatGptService();
  }
}
