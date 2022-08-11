import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:game/enemy_manager.dart';
import 'package:game/game_consts.dart';
import 'player.dart';

class MyGame extends FlameGame with PanDetector, HasCollisionDetection {
  late Player player;
  late EnemyManager enemyManager;
  late SpriteComponent background;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    /// load game images
    final backgroundImage = await images.load('background.png');
    final enemyImage = await images.load('cars/audi.png');

    final policeCar =
        [1, 2, 3].map((i) => Sprite.load('cars/police_animation/$i.png'));
    final explosion = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
        .map((i) => Sprite.load('explosion/circle_explosion$i.png'));

    /// load animations
    final policeCarAnimation = SpriteAnimation.spriteList(
      await Future.wait(policeCar),
      stepTime: 0.3,
    );

    SpriteAnimation explosionAnimation = SpriteAnimation.spriteList(
      await Future.wait(explosion),
      stepTime: 0.1,
      loop: false,
    );

    /// game background component
    background = SpriteComponent(
      sprite: Sprite(backgroundImage),
      size: size,
    );
    // add(background);

    /// player component
    player = Player(
      animationIdle: policeCarAnimation,
      animationExplosion: explosionAnimation,
      size: GameConsts.playerSize,
    )
      ..position = Vector2(size.x / 2, size.y / 1.4)
      ..debugMode = GameConsts.debugMode;
    add(player);

    /// enemy component
    enemyManager = EnemyManager(sprite: Sprite(enemyImage));
    add(enemyManager);
  }

  @override
  void onPanDown(DragDownInfo info) {
    if (info.eventPosition.game.x < size.x / 2) {
      player.moveLeft();
    } else if (info.eventPosition.game.x > size.x / 2) {
      player.moveRight();
    }
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

}
