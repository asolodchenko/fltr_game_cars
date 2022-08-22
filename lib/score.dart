import 'package:flame/components.dart';
import 'package:game/game.dart';

class Score extends TextComponent with HasGameRef<MyGame> {
  late String score;
  late Timer timer;

  Score() {
    //TODO! fix this approach. Create endless timer
    timer =
        Timer(999999999999999, onTick: () => score = timer.current.toString());
  }

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    timer.start();
    score = timer.current.toString();

    priority = 1;
    positionType = PositionType.viewport;
    text = score.toString();
    //TODO! fix timer position to center
    position = Vector2(gameRef.size.x /2 , 27);
    scale = Vector2(1, 1);
  }

  @override
  void update(double dt) {
    timer.update(dt);
    //TODO! remove dot at double...
    score = 'Score: ${timer.current.toStringAsFixed(1)}';
    text = score.toString();
  }

  @override
  void onMount() {
    timer.start();
  }

  @override
  void onRemove() {
    timer.stop();
  }

  void reset() {
    timer.stop();
    timer.start();
  }
}
