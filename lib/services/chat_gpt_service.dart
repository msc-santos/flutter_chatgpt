import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/common/constants.dart';
import 'package:flutter_chatgpt/interfaces/chat_interface.dart';
import 'package:flutter_chatgpt/models/chat_message.dart';
import 'package:flutter_chatgpt/models/chat_user.dart';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:flutter_chatgpt/services/auth_service.dart';
import 'package:flutter_chatgpt/states/loading_app.dart';
import 'package:provider/provider.dart';

class ChatGptService implements ChatService {
  static final List<ChatMessage> _msgs = [];
  static MultiStreamController<List<ChatMessage>>? _controller;
  
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  @override
  Future<void> callWithChatGpt(String question, BuildContext context) async {
    if (question.isEmpty) return;

    final LoadingAppState loadingAppState = Provider.of(context, listen: false);
    loadingAppState.setLoading(true);

    final chatGptBot = AuthService().currentBot;

    final chatGpt = ChatGpt(apiKey: apiKey);

    final request = CompletionRequest(
      stream: true,
      maxTokens: 4000,
      model: ChatGptModel.gpt35Turbo,
      messages: [
        Message(
          role: Role.user.name,
          content: question,
        ),
      ],
    );

    final stream = await chatGpt.createChatCompletionStream(request);

    if (stream == null) {
      loadingAppState.setLoading(false);
      return;
    }

    final completer = Completer();
    final buffer = StringBuffer();

    final streamSubscription = stream.listen((event) async {
      if (event.streamMessageEnd) completer.complete();

      final bufferMessage = event.choices?.first.delta?.content ?? '';
      buffer.write(bufferMessage);
    });

    await completer.future;
    await streamSubscription.cancel();

    loadingAppState.setLoading(false);
    await ChatService().send(buffer.toString(), chatGptBot!);
  }

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  @override
  Future<ChatMessage?> send(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );

    _msgs.add(newMessage);
    _controller?.add(_msgs.reversed.toList());

    return newMessage;
  }
}
