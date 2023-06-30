import 'dart:async';
import 'dart:math';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  int userChoice = 0;
  int systemChoice = 0;
  int numGames = 0;
  int scoreYou = 0;
  int scoreSystem = 0;
  double turns = 0.0;
  bool isPlay = false;

  void play(int choice) {
    if (isPlay) return;

    setState(() {
      isPlay = true;
      userChoice = choice;
      turns += 1.0;
    });

    Timer(const Duration(seconds: 1), () {
      setState(() {
        systemChoice = Random().nextInt(3);
        isPlay = false;
        numGames++;

        roundWinner();
        if (numGames == 5) _showResultDialog(context);
      });
    });
  }

  void roundWinner() {
    // 0 - paper
    // 1 - rock
    // 2 - scissors

    if ((userChoice == 0 && systemChoice == 2) ||
        (userChoice == 1 && systemChoice == 0) ||
        (userChoice == 2 && systemChoice == 1)) {
      scoreSystem++;
    } else if (userChoice != systemChoice) {
      scoreYou++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedOpacity(
              opacity: isPlay ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: isPlay ? 1 : 0,
                curve: Curves.easeInOut,
                child: AnimatedRotation(
                  turns: turns,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/btn0.png',
                        height: 30,
                        width: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/btn1.png',
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            'assets/btn2.png',
                            height: 30,
                            width: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      scale: !isPlay ? 1.0 : 0,
                      curve: Curves.easeInOut,
                      child: Image.asset('assets/btn$userChoice.png'),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'You',
                      style: TextStyle(fontSize: 24, color: Colors.blue),
                    ),
                  ],
                ),
                const Text(
                  'vs',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                Column(
                  children: [
                    AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      scale: !isPlay ? 1.0 : 0,
                      curve: Curves.easeInOut,
                      child: Image.asset('assets/btn$systemChoice.png'),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'System',
                      style: TextStyle(fontSize: 24, color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () => play(0),
                  child: Image.asset(
                    'assets/btn0.png',
                    height: 80,
                    width: 80,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => play(1),
                      child: Image.asset(
                        'assets/btn1.png',
                        height: 80,
                        width: 80,
                      ),
                    ),
                    TextButton(
                      onPressed: () => play(2),
                      child: Image.asset(
                        'assets/btn2.png',
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 44),
          ],
        ),
      ),
    );
  }

  _showResultDialog(context) {
    Alert(
      context: context,
      title: "Result Game",
      desc: (scoreYou > scoreSystem ? "you are win" : "you are loss"),
      alertAnimation: fadeAlertAnimation,
    ).show();
  }

  Widget fadeAlertAnimation(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
