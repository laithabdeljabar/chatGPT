import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt/controller/message_controller.dart';
import 'package:chatgpt/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final int index;
  const MessageWidget({Key? key, required this.message, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageController = Provider.of<MessageController>(context, listen: false);

    Size size = MediaQuery.of(context).size;
    return Material(
      color: message.index == 0 ? Theme.of(context).cardColor : Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            message.index == 0
                ? Image.asset(
                    'assets/image/chat_logo.png',
                    width: 30,
                  )
                : Image.asset(
                    'assets/image/user.png',
                    width: 30,
                  ),
            SizedBox(
              width: size.width * 0.03,
            ),
            Expanded(
                child: message.index == 0
                    ? AnimatedTextKit(
                        isRepeatingAnimation: false,
                        displayFullTextOnTap: true,
                        totalRepeatCount: 1,
                        repeatForever: false,
                        animatedTexts: [
                          TyperAnimatedText(
                            message.text.trim(),
                            textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    : Text(message.text, style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 15, fontWeight: FontWeight.normal))),
            if (message.index == 0)
              Selector<MessageController, int>(
                selector: (_, flag) => flag.messages[index].like ?? -1,
                builder: (context, like, _) => Row(
                  children: [
                    InkWell(
                      onTap: () => messageController.likeMessage(index, like == 1 ? false : true),
                      child: Icon(
                        like == 1 ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    InkWell(
                      onTap: () => messageController.dislikeMessage(index, like == 0 ? false : true),
                      child: Icon(
                        like == 0 ? Icons.thumb_down_alt : Icons.thumb_down_alt_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
