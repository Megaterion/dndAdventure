import 'dart:async';
import 'dart:ui';

import 'package:dnd_adventure/levels/level.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

class DnDAdventure extends FlameGame with HasKeyboardHandlerComponents {
  @override
  Color backgroundColor() => const Color.fromARGB(255, 237, 142, 142);
  late final CameraComponent cam;

  @override
  final world = Level(levelName: "testlvl");

  @override
  FutureOr<void> onLoad() async {
    // Lädt alle Bilder in den Cache
    await images.loadAllImages();

    cam = CameraComponent.withFixedResolution(
        world: world, width: 1280, height: 1280);
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, world]);
    return super.onLoad();
  }
}
