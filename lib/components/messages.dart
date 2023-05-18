import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/interfaces/chat_interface.dart';
import 'package:flutter_chatgpt/models/chat_message.dart';
import 'package:flutter_chatgpt/components/message.dart';
import 'package:flutter_chatgpt/services/auth_service.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;
    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('O que gostaria de perguntar ?'),
          );
        } else {
          final msgs = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (ctx, i) => Message(
              key: ValueKey(msgs[i].id),
              message: msgs[i],
              userOrChatGpt: currentUser?.id == msgs[i].userId,
            ),
          );
        }
      },
    );
  }
}
