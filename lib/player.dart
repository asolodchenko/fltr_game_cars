import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:game/enemy.dart';
import 'package:game/game_consts.dart';

enum PlayerState {
  idle,
  explosion,
}

class Player extends SpriteAnimationGroupComponent<PlayerState>
    with HasGameRef, CollisionCallbacks {
  int health = 5;

  final double moveDuration = GameConsts.playerMoveDuration;
  final Curve animationCurve = Curves.easeIn;
  final SpriteAnimation animationIdle;
  final SpriteAnimation animationExplosion;

  final removeEffect = RemoveEffect(delay: 1);

  bool canMoveLeft = true;
  bool canMoveRight = true;
  bool isCenter = true;

  Player({
    required this.animationIdle,
    required this.animationExplosion,
    Vector2? size,
    Vector2? position,
    Anchor? anchor,
  }) : super(
          size: size,
          position: position,
          anchor: Anchor.center,
          animations: {
            PlayerState.idle: animationIdle,
            PlayerState.explosion: animationExplosion,
          },
          current: PlayerState.idle,
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
      gameRef.camera.shake(intensity: 10);
      
      health -= 1;
      if (health <= 0) {
        health = 0;
        size = Vector2.all(256);
        current = PlayerState.explosion;

        Future.delayed(
          const Duration(seconds: 1),
          () => removeFromParent(),
        );
      }
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
