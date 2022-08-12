import 'package:flame/components.dart';

class Command<T extends Component> {
  void Function(T target) action;

  Command({required this.action});

  void runComponent(Component component) {
    if (component is T) {
      action.call(component);
    }
  }
}
