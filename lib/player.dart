import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';

class Player extends SpriteComponent with HasGameRef {
  final double moveDuration = 0.4;
  final Curve animationCurve = Curves.easeIn;
  // Vector2 _moveDirection = Vector2(0, 0);
  // final double _speed = 300;

  Player({
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
  void update(double dt) {
    super.update(dt);

    // position += _moveDirection.normalized() * _speed * dt;
    /// limits carachter to go out of the screen
    position.clamp(Vector2.zero() + size / 1.6, gameRef.size - size / 1.6);
  }

  // void setMoveDirection(Vector2 newMoveDirection) {
  //   _moveDirection = newMoveDirection;
  // }

  void moveLeft() {
    final effect = MoveByEffect(
        Vector2(-gameRef.size.x / 3, 0),
        EffectController(
          duration: moveDuration,
          curve: animationCurve,
        ));
    add(effect);
  }

  void moveRight() {
    final effect = MoveByEffect(
        Vector2(gameRef.size.x / 3, 0),
        EffectController(
          duration: moveDuration,
          curve: animationCurve,
        ));
    add(effect);
  }
}
