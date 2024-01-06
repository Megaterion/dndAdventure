import 'package:flame/components.dart';

class LevelCollider extends PositionComponent {
  String type;
  LevelCollider({
    position,
    size,
    this.type = "default",
  }) : super(position: position, size: size) {
    debugMode = true;
  }
}
