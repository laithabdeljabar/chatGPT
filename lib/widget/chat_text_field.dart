import 'package:chatgpt/controller/model_controller.dart';
import 'package:chatgpt/model/message_model.dart';
import 'package:chatgpt/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/message_controller.dart';
import 'erroe_widget_snackbar.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({Key? key, required this.controller, required this.focusNode, required this.scrollController}) : super(key: key);
  final FocusNode focusNode;
  final TextEditingController controller;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final messageController = Provider.of<MessageController>(context, listen: false);
    final modelController = Provider.of<ModelController>(context, listen: false);
    return Container(
      height: size.height * 0.08,
      color: Theme.of(context).cardColor,
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.02,
          ),
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              decoration: InputDecoration(
                  hintText: 'How can I help you ?',
                  hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white60),
                  border: InputBorder.none),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          IconButton(
              onPressed: () {
                if (controller.text.isEmpty) {
                  return;
                }
                messageController.addTomessageList(Message(text: controller.text, index: 1));
                if (modelController.selectedModel.toLowerCase().startsWith('gpt')) {
                  messageController
                      .sendGptMessage(
                          modelController.selectedModel,
                          controller.text,
                          () {
                            _loadingDialoge(context);
                          },
                          () => Navigator.pop(context),
                          () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                content: ErrorWidgetSnackBar(errorMessage: messageController.error)));
                          })
                      .then((value) => WidgetsBinding.instance.addPostFrameCallback((_) => _autoScroll(scrollController)));
                } else {
                  messageController
                      .sendMessage(
                          modelController.selectedModel,
                          controller.text,
                          () {
                            _loadingDialoge(context);
                          },
                          () => Navigator.pop(context),
                          () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                content: ErrorWidgetSnackBar(errorMessage: messageController.error)));
                          })
                      .then((value) => WidgetsBinding.instance.addPostFrameCallback((_) => _autoScroll(scrollController)));
                }
                controller.clear();
                focusNode.unfocus();
              },
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  _autoScroll(ScrollController scrollController) {
    scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  _loadingDialoge(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: const LoadingWidget()));
  }
}
