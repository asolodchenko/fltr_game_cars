import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game/enemy.dart';
import 'package:game/game_consts.dart';

class EnemyManager extends Component with HasGameRef {
  final Sprite sprite;

  Random random = Random();

  /// time of respawning enemies
  double enemyTimeSpawn = 1;
  late Timer timer;

  EnemyManager({
    required this.sprite,
  }) : super() {
    timer = Timer(enemyTimeSpawn, onTick: _spawnEnemy, repeat: true);
  }

  void _spawnEnemy() {
    /// enemy size
    Vector2 initialSize = GameConsts.playerSize;
    Vector2 position;
    position = _getEnemyPosition(initialSize);

    Enemy enemy = Enemy(
      sprite: sprite,
      size: initialSize,
      position: position,
    )
      ..debugMode = GameConsts.debugMode
      ..debugColor = Colors.red
      ..anchor = Anchor.center;

    gameRef.add(enemy);
  }

  Vector2 _getEnemyPosition(Vector2 initialSize) {
    Vector2 position = Vector2(0, 0);

    int randomNumber = random.nextInt(3);

    if (randomNumber == 0) {
      /// middle part of the screen
      position = Vector2(gameRef.size.x / 2, 0);
    } else if (randomNumber == 1) {
      /// left part of the screen
      position = Vector2(gameRef.size.x / 4, 0);
    } else if (randomNumber == 2) {
      /// right part of the screen
      position = Vector2(gameRef.size.x - (gameRef.size.x / 4), 0);
    }

    return position;
  }

  @override
  void onMount() {
    timer.start();
  }

  @override
  void onRemove() {
    timer.stop();
  }

  @override
  void update(double dt) {
    timer.update(dt);
  }
}
