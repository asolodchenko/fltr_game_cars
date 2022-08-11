import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:game/game_consts.dart';
import 'package:game/player.dart';

class Enemy extends SpriteComponent with HasGameRef, CollisionCallbacks {
  late SpriteAnimationComponent spriteAnimationComponent;
  final double _speed = 300;

  Enemy({
    Sprite? sprite,
    Vector2? size,
    Vector2? position,
    Anchor? anchor,
  }) : super(
          sprite: sprite,
          size: size,
          position: position,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final hitbox = RectangleHitbox.relative(
      Vector2(0.5, 0.9),
      parentSize: GameConsts.playerSize,
    );
    add(hitbox);

    final explosion = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
        .map((i) => Sprite.load('explosion/circle_explosion$i.png'));

    SpriteAnimation explosionAnimation = SpriteAnimation.spriteList(
      await Future.wait(explosion),
      stepTime: 0.1,
      loop: false,
    );

    spriteAnimationComponent = SpriteAnimationComponent(
      animation: explosionAnimation,
      anchor: Anchor.center,
    )..size = Vector2.all(256);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    onCollisionCallback?.call(intersectionPoints, other);

    if (other is Player) {
      spriteAnimationComponent.position = position.clone()..y += size.y / 4;
      gameRef.add(spriteAnimationComponent);

      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    position += Vector2(0, 1) * _speed * dt;

    if (position.y > gameRef.size.y + size.y) {
      gameRef.remove(this);
    }
  }
}
