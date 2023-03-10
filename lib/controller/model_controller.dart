import 'dart:convert';

import 'dart:io';

import 'package:chatgpt/controller/network_maneger/network_controller.dart';
import 'package:flutter/material.dart';

import '../model/model.dart';
import 'network_maneger/expeption.dart';
import 'network_maneger/url_components.dart';

class ModelController extends ChangeNotifier {
  String error = '';
  List<Model> models = [];

  String selectedModel = "gpt-3.5-turbo-0301";
  Future getAllModels() async {
    models = [];
    // selectedModel = null;
    try {
      String? response = await NetworkController().restApi(
        baseUrl,
        EndPoints.models.name,
        HttpMethod.GET,
        header: {'Authorization': 'Bearer $key'},
      );

      Map responseMap = json.decode(response ?? '');
      if (responseMap['error'] != null) {
        error = responseMap['error']['message'];
        throw CustomExeption(errorDescreption: error, statusCode: -1);
      }
      for (var model in responseMap['data']) {
        models.add(Model.fromJson(model));
      }
      notifyListeners();
    } on SocketException {
      error = 'Please  Chek internet ؤonnection';
    } on CustomExeption catch (e) {
      error = e.errorDescreption;
    } catch (e) {
      error = 'Server error';
    }
  }

  void setSelectedModel(String newModel) {
    selectedModel = newModel;
    notifyListeners();
  }
}
