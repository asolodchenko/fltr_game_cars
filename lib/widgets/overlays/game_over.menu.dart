import 'package:flutter/material.dart';

import '../game_button.dart';

class GameOverMenu extends StatelessWidget {
  final void Function()? onPressedRestart;
  final void Function()? onPressedExit;
  static const String id = 'GameOverMenu';

  const GameOverMenu({
    required this.onPressedRestart,
    required this.onPressedExit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Text(
              'Game Over',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GameButton(
            text: 'Restart',
            onPressed: onPressedRestart,
            textColor: Colors.white,
          ),
          GameButton(
            text: 'Exit',
            textColor: Colors.white,
            onPressed: onPressedExit,
          ),
        ],
      ),
    );
  }
}
