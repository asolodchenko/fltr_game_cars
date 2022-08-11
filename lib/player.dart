import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:game/enemy.dart';
import 'package:game/game_consts.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef, CollisionCallbacks {
  final double moveDuration = 0.4;
  final Curve animationCurve = Curves.easeIn;
  bool canMoveLeft = true;
  bool canMoveRight = true;
  bool isCenter = true;

  Player({
    SpriteAnimation? animation,
    Vector2? size,
    Vector2? position,
    Anchor? anchor,
  }) : super(
          animation: animation,
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
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    onCollisionCallback?.call(intersectionPoints, other);

    if (other is Enemy) {
      //TODO! implement collision
    }
  }

  void moveLeft() {
    final effect = MoveByEffect(
        Vector2(-gameRef.size.x / 4, 0),
        EffectController(
          duration: moveDuration,
          curve: animationCurve,
        ));
    if (canMoveLeft) {
      add(effect);
      isCenter = !isCenter;
      canMoveLeft = isCenter;
      canMoveRight = true;
    }
  }

  void moveRight() {
    final effect = MoveByEffect(
        Vector2(gameRef.size.x / 4, 0),
        EffectController(
          duration: moveDuration,
          curve: animationCurve,
        ));
    if (canMoveRight) {
      add(effect);
      isCenter = !isCenter;
      canMoveRight = isCenter;
      canMoveLeft = true;
    }
  }
}
