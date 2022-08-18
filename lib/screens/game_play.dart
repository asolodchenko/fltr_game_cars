import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game/game.dart';
import 'package:game/screens/main_menu.dart';
import 'package:game/widgets/overlays/pause_button.dart';
import 'package:game/widgets/overlays/pause_menu.dart';

MyGame _myGame = MyGame();

class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: GameWidget(
          game: _myGame,
          initialActiveOverlays: const [PauseButton.id],
          overlayBuilderMap: {
            PauseButton.id: (BuildContext context, MyGame gameRef) =>
                PauseButton(
                  onPressed: () {
                    gameRef.pauseEngine();
                    gameRef.overlays.add(PauseMenu.id);
                    gameRef.overlays.remove(PauseButton.id);
                  },
                ),
            PauseMenu.id: (BuildContext context, MyGame gameRef) => PauseMenu(
                  onPressedResume: () {
                    gameRef.resumeEngine();
                    gameRef.overlays.remove(PauseMenu.id);
                    gameRef.overlays.add(PauseButton.id);
                  },
                  onPressedRestart: () {
                    gameRef.overlays.remove(PauseMenu.id);
                    gameRef.overlays.add(PauseButton.id);
                    gameRef.resumeEngine();
                    gameRef.reset();
                  },
                  onPressedExit: () {
                    gameRef.resumeEngine();
                    gameRef.overlays.remove(PauseMenu.id);
                    gameRef.reset();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: ((context) => const MainMenu()),
                    ));
                  },
                ),
          },
        ),
      ),
    );
  }
}
