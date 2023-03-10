import 'package:chatgpt/controller/message_controller.dart';
import 'package:chatgpt/view/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/model_controller.dart';
import 'core/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ModelController()),
        ChangeNotifierProvider(create: (context) => MessageController()),
      ],
      child: MaterialApp(
        title: 'ChatGPT',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: const Home(),
      ),
    );
  }
}
