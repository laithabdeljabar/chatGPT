import 'package:chatgpt/controller/model_controller.dart';
import 'package:chatgpt/widget/model_drop_down_botton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/chat_list.dart';
import '../widget/chat_text_field.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController controller;

  late FocusNode focusNode;

  late ScrollController scrollController;
  @override
  void initState() {
    Provider.of<ModelController>(context, listen: false).getAllModels();
    controller = TextEditingController();
    scrollController = ScrollController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/image/openai_logo.jpg',
        ),
        title: const Text('ChatGPT'),
        actions: [
          IconButton(
              onPressed: () async {
                await showModalBottomSheet(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    context: context,
                    builder: (context) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.02),
                          child: const ModelDropDownBotton(),
                        ));
              },
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        children: [
          ChatList(
            scrollController: scrollController,
          ),
          // TypingWidget(),
          ChatTextField(
            scrollController: scrollController,
            focusNode: focusNode,
            controller: controller,
          )
        ],
      ),
    );
  }
}
