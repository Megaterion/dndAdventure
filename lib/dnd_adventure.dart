import 'dart:async';

import 'package:dnd_adventure/levels/level.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class DnDAdventure extends FlameGame {
  late final CameraComponent cam;

  final world = Level();

  @override
  FutureOr<void> onLoad() {
    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, world]);
    return super.onLoad();
  }
}
