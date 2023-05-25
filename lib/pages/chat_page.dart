import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/components/messages.dart';
import 'package:flutter_chatgpt/components/new_message.dart';
import 'package:flutter_chatgpt/routes/app_routes.dart';
import 'package:flutter_chatgpt/states/loading_app.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'Flutter Chat GPT',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 16.0),
            color: Theme.of(context).colorScheme.background,
            iconSize: 26.0,
            icon: const Icon(Icons.arrow_forward),
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.tensorflow),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const Expanded(
              child: Messages(),
            ),
            const NewMessage(),
            Consumer<LoadingAppState>(
              builder: (_, value, child) {
                if (value.loading) {
                  return LinearProgressIndicator(
                    value: controller.value,
                    semanticsLabel: 'Linear progress indicator',
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
