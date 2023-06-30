import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyAnimation());
}

class MyAnimation extends StatefulWidget {
  const MyAnimation({Key? key}) : super(key: key);

  @override
  State<MyAnimation> createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation> {
  double scale = 1.0;
  double turn = 0;

  Duration duration = const Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: AnimatedRotation(
            turns: turn,
            duration: Duration(seconds: 2),
            curve: Curves.bounceIn,
            child: AnimatedScale(
              scale: scale,
              duration: duration,
              curve: Curves.easeInOut,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    scale = 2;
                    turn += 1;
                  });
                  Timer(duration, () {
                    setState(() {
                      scale = 1;
                      turn += 1;
                    });
                  });
                },
                child: const Icon(
                  Icons.access_alarm,
                  size: 56,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
