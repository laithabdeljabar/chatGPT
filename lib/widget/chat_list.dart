import 'package:chatgpt/controller/message_controller.dart';
import 'package:chatgpt/widget/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key, required this.scrollController}) : super(key: key);
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    final messageController = Provider.of<MessageController>(context, listen: false);
    return Selector<MessageController, int>(
      selector: (_, messageList) => messageList.messages.length,
      builder: (context, length, _) => Flexible(
          child: ListView.builder(
        controller: scrollController,
        itemCount: length,
        itemBuilder: (context, index) {
          return MessageWidget(
            message: messageController.messages[index],
            index: index,
          );
        },
      )),
    );
  }
}
