import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:game/ambulance_manager.dart';
import 'package:game/command.dart';
import 'package:game/enemy_manager.dart';
import 'package:game/game_consts.dart';
import 'package:game/health.dart';
import 'player.dart';

class MyGame extends FlameGame with PanDetector, HasCollisionDetection {
  late Player _player;
  late EnemyManager _enemyManager;
  late AmbulanceManager _ambulanceManager;

  Player get player => _player;

  final _comandList = List<Command>.empty(growable: true);
  final _addLaterComandList = List<Command>.empty(growable: true);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    /// load game images
    final playerImage = await images.load('cars/police.png');
    final enemyImage = await images.load('cars/audi.png');

    final policeCar =
        [1, 2, 3].map((i) => Sprite.load('cars/police_animation/$i.png'));
    final explosion = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
        .map((i) => Sprite.load('explosion/circle_explosion$i.png'));
    final ambulanceCar =
        [1, 2, 3].map((i) => Sprite.load('cars/ambulance_animation/$i.png'));

    /// load animations
    final policeCarAnimation = SpriteAnimation.spriteList(
      await Future.wait(policeCar),
      stepTime: 0.2,
    );
    final explosionAnimation = SpriteAnimation.spriteList(
      await Future.wait(explosion),
      stepTime: 0.1,
      loop: false,
    );
    final ambulanceAnimation = SpriteAnimation.spriteList(
      await Future.wait(ambulanceCar),
      stepTime: 0.2,
    );

    final parallaxImages = [
      ParallaxImageData('background.png'),
    ];

    final parallax = await loadParallaxComponent(
      parallaxImages,
      priority: 0,
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(0, -50),
      velocityMultiplierDelta: Vector2(0, 20),
      alignment: Alignment.center,
      fill: LayerFill.width,
    );

    add(parallax);

    /// player component
    _player = Player(
      animationIdle: policeCarAnimation,
      animationExplosion: explosionAnimation,
      size: GameConsts.playerSize,
    )..position = Vector2(size.x / 2, size.y / 1.4);

    add(_player);

    /// enemy component
    _enemyManager = EnemyManager(sprite: Sprite(enemyImage));
    add(_enemyManager);

    /// ambulance component
    _ambulanceManager = AmbulanceManager(animation: ambulanceAnimation);
    add(_ambulanceManager);

    /// health component
    add(Health(image: playerImage));
  }

  @override
  void onPanDown(DragDownInfo info) {
    if (info.eventPosition.game.x < size.x / 2) {
      _player.moveLeft();
    } else if (info.eventPosition.game.x > size.x / 2) {
      _player.moveRight();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    for (var command in _comandList) {
      for (var component in children) {
        command.runComponent(component);
      }
    }

    _comandList.clear();
    _comandList.addAll(_addLaterComandList);
    _addLaterComandList.clear();
  }

  void addCommand(Command command) {
    _addLaterComandList.add(command);
  }

  /// this is swipe detection
  // @override
  // void onPanUpdate(DragUpdateInfo info) {
  //   double swipeVelocity = 10;

  //   /// leftSwipe
  //   if (info.eventPosition.viewport.x < -swipeVelocity) {
  //     // player.setMoveDirection(Vector2(-1, 0));

  //     /// right swipe
  //   } else if (info.delta.viewport.x > swipeVelocity) {
  //     // player.setMoveDirection(Vector2(1, 0));

  //     /// up swipe
  //   } else if (info.delta.viewport.y < -swipeVelocity) {
  //     // player.setMoveDirection(Vector2(0, -1));

  //     /// down swipe
  //   } else if (info.delta.viewport.y > swipeVelocity) {
  //     // player.setMoveDirection(Vector2(0, 1));

  //   }
  // }

}
