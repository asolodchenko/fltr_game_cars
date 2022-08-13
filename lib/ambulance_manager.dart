import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game/ambulance.dart';

import 'package:game/game_consts.dart';

class AmbulanceManager extends Component with HasGameRef {
  final SpriteAnimation animation;

  final _random = Random();

  /// time of respawning enemies
  final double _enemyTimeSpawn = 5;
  late Timer _timer;

  AmbulanceManager({
    required this.animation,
  }) : super() {
    _timer = Timer(_enemyTimeSpawn, onTick: _spawnEnemy, repeat: true);
  }

  void _spawnEnemy() {
    Vector2 initialSize = GameConsts.playerSize * 1.3;
    Vector2 position;
    position = _getAmbulancePosition();

    Ambulance ambulance = Ambulance(
      animation: animation,
      size: initialSize,
      position: position,
    )
      ..debugColor = Colors.red
      ..anchor = Anchor.center;

    gameRef.add(ambulance);
  }

  Vector2 _getAmbulancePosition() {
    Vector2 position = Vector2(0, 0);

    int randomNumber = _random.nextInt(3);

    if (randomNumber == 0) {
      /// middle part of the screen
      position = Vector2(gameRef.size.x / 2, gameRef.size.y);
    } else if (randomNumber == 1) {
      /// left part of the screen
      position = Vector2(gameRef.size.x / 4, gameRef.size.y);
    } else if (randomNumber == 2) {
      /// right part of the screen
      position = Vector2(gameRef.size.x - (gameRef.size.x / 4), gameRef.size.y);
    }

    return position;
  }

  @override
  void onMount() {
    _timer.start();
  }

  @override
  void onRemove() {
    _timer.stop();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
  }
}
