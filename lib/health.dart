import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:game/game.dart';
import 'package:game/game_consts.dart';

class Health extends TextComponent with HasGameRef<MyGame> {
  final Image image;
  late String health;

  Health({required this.image});

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    final healthComponent = SpriteComponent(
      sprite: Sprite(image),
      size: GameConsts.playerSize / 3,
      position: Vector2(40, 40),
      anchor: Anchor.center,
    )..positionType = PositionType.viewport;

    gameRef.add(healthComponent);

    health = gameRef.player.health.toString();
    priority = 1;
    positionType = PositionType.viewport;
    text = 'x $health';
    position = Vector2(55, 27);
    scale = Vector2(1, 1);
  }

  @override
  void update(double dt) {
    health = gameRef.player.health.toString();
    text = 'x $health';
  }
}
