import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * math.pi,
            child: child,
          );
        },
        child: Image.asset(
          'assets/image/openai_logo-removebg-preview.png',
          width: size.width * 0.6,
        ),
      ),
    );
  }
}
