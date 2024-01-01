import 'package:flame/components.dart';

class CollisionHandler extends PositionComponent {
  String type;
  CollisionHandler({
    position,
    size,
    this.type = "default",
  }) : super(position: position, size: size) {
    debugMode = true;
  }
}
