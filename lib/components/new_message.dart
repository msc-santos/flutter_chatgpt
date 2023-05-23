import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/interfaces/chat_interface.dart';
import 'package:flutter_chatgpt/services/auth_service.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _message = '';
  final _messageController = TextEditingController();

  Future<void> _sendMessage(context) async {
    final user = AuthService().currentUser;
    ChatService chatService = ChatService();

    if (user != null) {
      await chatService.send(_message, user);
      _messageController.clear();

      chatService.callWithChatGpt(_message, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              onChanged: (msg) => setState(() => _message = msg),
              decoration: const InputDecoration(
                labelText: 'Enviar mensagem...',
              ),
              onSubmitted: (_) {
                if (_message.trim().isNotEmpty) {
                  _sendMessage(context);
                }
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () =>
                _message.trim().isEmpty ? null : _sendMessage(context),
          ),
        ],
      ),
    );
  }
}
