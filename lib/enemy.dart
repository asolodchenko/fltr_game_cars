import 'dart:math';
import 'package:flame/components.dart';

class Enemy extends SpriteComponent with HasGameRef {
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
        ) {
    angle = pi;
  }

  @override
  void update(double dt) {
    position += Vector2(0, 1) * _speed * dt;

    if (position.y > gameRef.size.y + size.y) {
      gameRef.remove(this);
    }
  }
}
