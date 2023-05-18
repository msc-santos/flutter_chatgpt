import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/models/chat_message.dart';

class Message extends StatelessWidget {
  static const _defaultImage = 'assets/images/avatar.png';
  final ChatMessage message;
  final bool userOrChatGpt;

  const Message({
    required this.message,
    required this.userOrChatGpt,
    super.key,
  });

  Widget _showUserImage(String imageUrl) {
    ImageProvider? provider;

    provider = const AssetImage(_defaultImage);

    return CircleAvatar(
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              userOrChatGpt ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: userOrChatGpt
                    ? Colors.grey.shade300
                    : Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: userOrChatGpt
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                  bottomRight: userOrChatGpt
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              width: 180,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: Column(
                crossAxisAlignment: userOrChatGpt
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.userName,
                    style: TextStyle(
                      color: userOrChatGpt ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    message.text,
                    textAlign: userOrChatGpt ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      color: userOrChatGpt ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: userOrChatGpt ? null : 165,
          right: userOrChatGpt ? 165 : null,
          child: _showUserImage(message.userImageUrl),
        ),
      ],
    );
  }
}
