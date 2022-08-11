import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';

class Player extends SpriteAnimationComponent with HasGameRef {
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
