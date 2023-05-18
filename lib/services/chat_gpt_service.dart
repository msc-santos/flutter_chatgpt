import 'dart:async';
import 'dart:math';
import 'package:flutter_chatgpt/interfaces/chat_interface.dart';
import 'package:flutter_chatgpt/models/chat_message.dart';
import 'package:flutter_chatgpt/models/chat_user.dart';
import 'package:flutter_chatgpt/services/auth_service.dart';

class ChatGptService implements ChatService {
  static final List<ChatMessage> _msgs = [];

  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  @override
  Future<void> callWithChatGpt(String question) async {
    if (question.isEmpty) return;

    final chatGptBot = AuthService().currentBot;
    await ChatService().send('...', chatGptBot!);

    // // TODO: setar um loading de state para true

    // final chatGpt = ChatGpt(apiKey: apiKey);

    // final request = CompletionRequest(
    //   stream: true,
    //   maxTokens: 4000,
    //   model: ChatGptModel.gpt35Turbo,
    //   messages: [
    //     Message(
    //       role: Role.user.name,
    //       content: question,
    //     ),
    //   ],
    // );

    // final stream = await chatGpt.createChatCompletionStream(request);

    // if (stream == null) {
    //   // TODO: setar um loading de state para false
    //   return;
    // }

    // final completer = Completer();
    // final buffer = StringBuffer();

    // final streamSubscription = stream.listen((event) {
    //   if (event.streamMessageEnd) {
    //     // TODO: setar um loading de state para false
    //     completer.complete();

    //     final bufferMessage = event.choices?.first.delta?.content ?? '';
    //     print("Mensagem gerada---");
    //     print(event);
    //     // buffer.write(bufferMessage);
    //   }
    // });

    // await completer.future;
    // await streamSubscription.cancel();
  }

  // TODO: aqui é onde vai retornar os dados vindos da callWithChatGpt e converter em um ChatMessage ou uma lista de ChatMessage
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
