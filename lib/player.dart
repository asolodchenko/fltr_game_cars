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
  final SpriteAnimation animationIdle;
  final SpriteAnimation animationExplosion;

  final double _moveDuration = GameConsts.playerMoveDuration;
  final Curve _animationCurve = Curves.easeIn;

  int _health = 5;
  int get health => _health;

  bool _canMoveLeft = true;
  bool _canMoveRight = true;
  bool _isCenter = true;

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
      Vector2(0.3, 0.7),
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

      _health -= 1;
      if (_health <= 0) {
        _health = 0;
        size = Vector2.all(256);
        current = PlayerState.explosion;

        Future.delayed(
          const Duration(milliseconds: 500),
          () => removeFromParent(),
        );
      }
    }
  }

  void moveLeft() {
    final effect = MoveByEffect(
        Vector2(-gameRef.size.x / 4, 0),
        EffectController(
          duration: _moveDuration,
          curve: _animationCurve,
        ));
    if (_canMoveLeft) {
      add(effect);
      _isCenter = !_isCenter;
      _canMoveLeft = _isCenter;
      _canMoveRight = true;
    }
  }

  void moveRight() {
    final effect = MoveByEffect(
        Vector2(gameRef.size.x / 4, 0),
        EffectController(
          duration: _moveDuration,
          curve: _animationCurve,
        ));
    if (_canMoveRight) {
      add(effect);
      _isCenter = !_isCenter;
      _canMoveRight = _isCenter;
      _canMoveLeft = true;
    }
  }

  void setHealth(int health) {
    _health = health;
  }
}
