import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:game/game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Set the game full
  Flame.device.fullScreen();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  final game = MyGame();
  runApp(GameWidget(game: game));
}
