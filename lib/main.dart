import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MainScreen(),
  ));
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? computerChoice = 'rock_btn';
  String? userChoice = "scisor_btn";
  late String gameScore;
  int score = 0;
  int playCount = 0;
  List<String> playResults = [];

  @override
  Widget build(BuildContext context) {
    comapreResult();

    return Scaffold(
      backgroundColor: const Color(0xFF060A47),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 5.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Row(
                    children: playResults.map((result) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 6),
                          Image.asset(
                            "assets/$result.png",
                            width: 30,
                            height: 30,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            /* Setting the Game play pad */
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          int randomIndex = Random().nextInt(3);
                          userChoice = [
                            'rock_btn',
                            'paper_btn',
                            'scisor_btn'
                          ][randomIndex];
                          playCount++;
                          playResults.add(gameScore);
                          score++;
                          if (playCount == 8) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Game Over'),
                                  content: Column(
                                    children: [
                                      const Text('Final Result:'),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Score: $score',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        });
                      },
                      child: Image.asset("assets/$userChoice.png"),
                    ),
                    const Text(
                      "VS",
                      style: TextStyle(color: Colors.white, fontSize: 26.0),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          int randomIndex = Random().nextInt(3);
                          computerChoice = [
                            'rock_btn',
                            'paper_btn',
                            'scisor_btn'
                          ][randomIndex];
                        });
                      },
                      child: Image.asset("assets/$computerChoice.png"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void comapreResult() {
    if (computerChoice == userChoice) {
      gameScore = "equality";
    } else if (userChoice == "paper_btn" && computerChoice == 'rock_btn') {
      gameScore = "like";
      ++score;
    } else if (userChoice == "paper_btn" && computerChoice == 'scissor_btn') {
      gameScore = "dislike";
    } else if (userChoice == 'rock_btn' && computerChoice == 'paper_btn') {
      gameScore = "dislike";
    } else if (userChoice == 'rock_btn' && computerChoice == 'scissor_btn') {
      gameScore = "like";
      ++score;
    } else if (userChoice == 'scisor_btn' && computerChoice == 'paper_btn') {
      gameScore = "like";
      ++score;
    } else if (userChoice == 'scisor_btn' && computerChoice == 'rock_btn') {
      gameScore = "dislike";
    }
  }
}
