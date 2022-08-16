import 'package:flutter/material.dart';
import 'package:game/screens/game_play.dart';
import 'package:game/widgets/game_button.dart';

class MainMenu extends StatelessWidget {
  static const String id = 'MainMenu';
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Text(
                '2D racing',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GameButton(
              text: 'Play',
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: ((context) => const GamePlay()),
                ));
              },
            ),
            GameButton(
              text: 'Options',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
