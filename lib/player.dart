import 'package:flame/components.dart';

class Player extends SpriteComponent with HasGameRef {
  Vector2 _moveDirection = Vector2.zero();
  final double _speed = 300;

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

    position += _moveDirection.normalized() * _speed * dt;
    position.clamp(Vector2.zero() + size / 1.5, gameRef.size - size / 1.5);
  }

  void setMoveDirection(Vector2 newMoveDirection) {
    _moveDirection = newMoveDirection;
  }
}
