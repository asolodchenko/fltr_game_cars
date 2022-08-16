import 'package:flutter/material.dart';

import '../game_button.dart';

class PauseMenu extends StatelessWidget {
  final void Function()? onPressedResume;
  final void Function()? onPressedExit;
  static const String id = 'PauseMenu';

  const PauseMenu({
    required this.onPressedResume,
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
              'Paused',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GameButton(
            text: 'Resume',
            onPressed: onPressedResume,
            textColor: Colors.white,
          ),
          //TODO! restart button ?
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
