import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:game/game.dart';
import 'package:game/game_consts.dart';

class Ambulance extends SpriteAnimationComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  final double _speed = 200;

  Ambulance({
    SpriteAnimation? animation,
    Sprite? sprite,
    Vector2? size,
    Vector2? position,
    Anchor? anchor,
  }) : super(
          animation: animation,
          position: position,
          size: size,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final hitbox = RectangleHitbox.relative(
      Vector2(0.3, 0.7),
      parentSize: GameConsts.playerSize * 1.3,
      anchor: Anchor.center,
    );
    add(hitbox);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    onCollisionCallback?.call(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position -= Vector2(0, 1) * _speed * dt;

    if (position.y + size.y < 0) {
      gameRef.remove(this);
    }
  }
}
