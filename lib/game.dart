import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'player.dart';

class MyGame extends FlameGame with PanDetector {
  late Player player;
  late SpriteComponent background;

  double gravity = 2;
  Vector2 velocity = Vector2(0, 0);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    /// load game images
    final playerImage = await images.load('player.png');
    final backgroundImage = await images.load('background.png');

    /// game background component
    background = SpriteComponent(
      sprite: Sprite(backgroundImage),
      size: size,
    );
    add(background);

    /// player component
    player = Player(
      sprite: Sprite(playerImage),
      size: Vector2(100, 150),
      position: size / 2,
    );
    add(player);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    double swipeVelocity = 10;

    /// leftSwipe
    if (info.delta.viewport.x < -swipeVelocity) {
      player.setMoveDirection(Vector2(-1, 0));
      print('left swipe');

      /// right swipe
    } else if (info.delta.viewport.x > swipeVelocity) {
      player.setMoveDirection(Vector2(1, 0));
      print('right swipe');

      /// up swipe
    } else if (info.delta.viewport.y < -swipeVelocity) {
      // player.setMoveDirection(Vector2(0, -1));
      print('up swite');

      /// down swipe
    } else if (info.delta.viewport.y > swipeVelocity) {
      // player.setMoveDirection(Vector2(0, 1));
      print('down swipe');
    }
  }
}
