import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/pages/chat_page.dart';
import 'package:flutter_chatgpt/states/loading_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoadingAppState(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Chat GPT',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            onPrimary: Colors.green,
            background: Colors.white,
          ),
          useMaterial3: true,
        ),
        home: const ChatPage(),
      ),
    );
  }
}
