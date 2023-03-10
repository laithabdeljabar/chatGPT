import 'package:chatgpt/controller/model_controller.dart';
import 'package:chatgpt/model/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModelDropDownBotton extends StatelessWidget {
  const ModelDropDownBotton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final modelController = Provider.of<ModelController>(context, listen: false);

    return Selector<ModelController, List<Model>>(
      selector: (p0, p1) => p1.models,
      builder: (context, value, child) {
        return Selector<ModelController, String?>(
          selector: (_, controller) => controller.selectedModel,
          builder: (context, selectedEvaluation, child) {
            return DropdownButton(
              isExpanded: true,
              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              iconEnabledColor: Colors.white,
              items: List<DropdownMenuItem<String>>.generate(
                  modelController.models.length,
                  (index) => DropdownMenuItem(
                        value: modelController.models[index].id,
                        child: Text(
                          modelController.models[index].id,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      )),
              value: modelController.selectedModel,
              onChanged: (value) {
                modelController.setSelectedModel(
                  value.toString(),
                );
              },
            );
          },
        );
      },
    );
  }
}
