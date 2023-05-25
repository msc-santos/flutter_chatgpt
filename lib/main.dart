import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/pages/chat_page.dart';
import 'package:flutter_chatgpt/pages/tensorflow_page.dart';
import 'package:flutter_chatgpt/states/loading_app.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chatgpt/routes/app_routes.dart';

void main() async {
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
        routes: {
          AppRoutes.home: (ctx) => const ChatPage(),
          AppRoutes.tensorflow: (ctx) => const TensorflowPage(),
        },
      ),
    );
  }
}
