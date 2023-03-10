import 'package:flutter/material.dart';

class ErrorWidgetSnackBar extends StatelessWidget {
  const ErrorWidgetSnackBar({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Row(
        children: [
          Image.asset(
            'assets/image/error (2).png',
            width: 35,
          ),
          SizedBox(
            width: size.width * 0.035,
          ),
          Expanded(
            child: Text(
              errorMessage,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          )
        ],
      ),
    );
  }
}
