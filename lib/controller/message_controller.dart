import 'dart:convert';
import 'dart:io';

import 'package:chatgpt/controller/network_maneger/network_controller.dart';
import 'package:chatgpt/model/message_model.dart';
import 'package:flutter/material.dart';

import 'network_maneger/url_components.dart';

class MessageController extends ChangeNotifier {
  String error = '';
  List<Message> messages = [];
  Future sendMessage(
    String model,
    String prompt,
    Function onLoading,
    Function onSuccess,
    Function onFail,
  ) async {
    onLoading();
    try {
      String? response = await NetworkController().restApi(
        baseUrl,
        EndPoints.completions.name,
        HttpMethod.POST,
        header: {'Authorization': 'Bearer $key', 'Content-Type': 'application/json'},
        body: {"model": model, "prompt": prompt, "max_tokens": 100},
      );
      Map responseMap = json.decode(response ?? '');

      if (responseMap['error'] != null) {
        error = responseMap['error']['message'];
        onFail();
      } else {
        Message message = Message(
          text: responseMap["choices"][0]["text"],
          index: 0,
          like: -1,
        );
        onSuccess();
        addTomessageList(message);
      }
      notifyListeners();
    } on SocketException {
      error = 'Please chek internet connection';
      onFail();
    } catch (e) {
      error = 'Server error';
      onFail();
    }
  }

  Future sendGptMessage(
    String model,
    String content,
    Function onLoading,
    Function onSuccess,
    Function onFail,
  ) async {
    onLoading();
    //  isTyping = true;
    try {
      String? response = await NetworkController().restApi(
        baseUrl,
        '${EndPoints.chat.name}/${EndPoints.completions.name}',
        HttpMethod.POST,
        header: {
          'Authorization': 'Bearer $key',
          'Content-Type': 'application/json',
        },
        body: {
          "model": model,
          "messages": [
            {"role": "user", "content": content}
          ]
        },
      );
      Map responseMap = json.decode(response ?? '');

      if (responseMap['error'] != null) {
        error = responseMap['error']['message'];
        onFail();
      } else {
        Message message = Message(
          text: responseMap["choices"][0]["message"]["content"],
          index: 0,
          like: -1,
        );
        onSuccess();
        addTomessageList(message);
      }
      notifyListeners();
    } on SocketException {
      error = 'Please chek internet connection';
      onFail();
    } catch (e) {
      error = 'Server error';
      onFail();
    }
  }

  addTomessageList(Message message) {
    messages.add(message);
    notifyListeners();
  }

  likeMessage(int index, bool like) {
    if (like) {
      messages[index].like = 1;
    } else {
      messages[index].like = -1;
    }

    notifyListeners();
  }

  dislikeMessage(int index, bool dislike) {
    if (dislike) {
      messages[index].like = 0;
    } else {
      messages[index].like = -1;
    }

    notifyListeners();
  }
}
