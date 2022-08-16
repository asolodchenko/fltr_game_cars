import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:game/ambulance_manager.dart';
import 'package:game/command.dart';
import 'package:game/enemy.dart';
import 'package:game/enemy_manager.dart';
import 'package:game/game_consts.dart';
import 'package:game/health.dart';
import 'player.dart';

class MyGame extends FlameGame with PanDetector, HasCollisionDetection {
  late Player _player;
  late EnemyManager _enemyManager;
  late AmbulanceManager _ambulanceManager;
  late SpriteAnimationComponent _fireComponent;
  late SpriteAnimationComponent _smokeComponent;

  bool isAlreadyLoaded = false;

  Player get player => _player;

  final _comandList = List<Command>.empty(growable: true);
  final _addLaterComandList = List<Command>.empty(growable: true);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    if (!isAlreadyLoaded) {
      /// load game images
      final playerImage = await images.load('cars/police.png');
      final enemyImage = await images.load('cars/audi.png');

      final policeCar =
          [1, 2, 3].map((i) => Sprite.load('cars/police_animation/$i.png'));
      final explosion = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
          .map((i) => Sprite.load('explosion/circle_explosion$i.png'));
      final ambulanceCar =
          [1, 2, 3].map((i) => Sprite.load('cars/ambulance_animation/$i.png'));
      final fire = [1, 2, 3, 4, 5, 6].map((i) => Sprite.load('fire/$i.png'));
      final smoke = [1, 2, 3, 4, 5, 6].map((i) => Sprite.load('smoke/$i.png'));

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
      final fireAnimaiton = SpriteAnimation.spriteList(
        await Future.wait(fire),
        stepTime: 0.2,
        loop: true,
      );
      final smokeAnimaiton = SpriteAnimation.spriteList(
        await Future.wait(smoke),
        stepTime: 0.2,
        loop: true,
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

      /// smoke component
      _smokeComponent = SpriteAnimationComponent(animation: smokeAnimaiton)
        ..position = player.position
        ..anchor = Anchor.center
        ..size = Vector2.all(0);
      add(_smokeComponent);

      /// fire component
      _fireComponent = SpriteAnimationComponent(animation: fireAnimaiton)
        ..size = Vector2.all(0)
        ..position = player.position
        ..anchor = Anchor.center;

      add(_fireComponent);

      /// health component
      // add(Health(image: playerImage));
      isAlreadyLoaded = false;
    }
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
    _updateComands();
    _getPlayerCarBurning();
  }

  void _updateComands() {
    for (var command in _comandList) {
      for (var component in children) {
        command.runComponent(component);
      }
    }
    _comandList.clear();
    _comandList.addAll(_addLaterComandList);
    _addLaterComandList.clear();
  }

  void _getPlayerCarBurning() {
    _fireComponent.position =
        Vector2(player.position.x, player.position.y - player.size.y / 2);
    _smokeComponent.position =
        Vector2(player.position.x, player.position.y - player.size.y / 2);

    if (player.health == 3) {
      _smokeComponent.size = Vector2.all(48);
    } else if (player.health == 2) {
      _fireComponent.size = Vector2.all(48);
      _smokeComponent.size = Vector2.all(48);
    } else if (player.health == 1) {
      _fireComponent.size = Vector2.all(64);
      _smokeComponent.size = Vector2.all(64);
    } else if (player.health == 0) {
      _fireComponent.size = Vector2.all(0);
      _smokeComponent.size = Vector2.all(0);
    }
  }

  void addCommand(Command command) {
    _addLaterComandList.add(command);
  }

  void reset() {
    _player.reset();
    _enemyManager.reset();
    _ambulanceManager.reset();
    _fireComponent
      ..size = Vector2.all(0)
      ..position = player.position;
    _smokeComponent
      ..size = Vector2.all(0)
      ..position = player.position;

    children.whereType<Enemy>().forEach((enemy) {
      enemy.removeFromParent();
    });
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
