import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:game/enemy_manager.dart';
import 'player.dart';

class MyGame extends FlameGame with PanDetector {
  late Player player;
  late EnemyManager enemyManager;
  late SpriteComponent background;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    /// load game images
    final playerImage = await images.load('player.png');
    // final enemyImage = await images.load('enemy.png');
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
        size: Vector2(65, 100),
        position: Vector2(size.x / 2, size.y / 1.2))
      ..debugMode = true;
    add(player);

    /// enemy component
    enemyManager = EnemyManager(sprite: Sprite(playerImage));
    add(enemyManager);
  }

  /// this is swipe detection
  // @override
  // void onPanUpdate(DragUpdateInfo info) {
  //   double swipeVelocity = 10;

  //   /// leftSwipe
  //   if (info.eventPosition.viewport.x < -swipeVelocity) {
  //     // player.setMoveDirection(Vector2(-1, 0));

  //     /// right swipe
  //   } else if (info.delta.viewport.x > swipeVelocity) {
  //     // player.setMoveDirection(Vector2(1, 0));

  //     /// up swipe
  //   } else if (info.delta.viewport.y < -swipeVelocity) {
  //     // player.setMoveDirection(Vector2(0, -1));

  //     /// down swipe
  //   } else if (info.delta.viewport.y > swipeVelocity) {
  //     // player.setMoveDirection(Vector2(0, 1));

  //   }
  // }

  @override
  void onPanDown(DragDownInfo info) {
    if (info.eventPosition.game.x < size.x / 2) {
      player.moveLeft();
    } else if (info.eventPosition.game.x > size.x / 2) {
      player.moveRight();
    }
  }
}
