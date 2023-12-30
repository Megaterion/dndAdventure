import 'dart:async';
import 'dart:ui';

import 'package:dnd_adventure/game/level/level.dart';
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
        world: world, width: 480, height: 255);
    cam.viewfinder.anchor = Anchor.center;

    addAll([cam, world]);
    return super.onLoad();
  }
}
