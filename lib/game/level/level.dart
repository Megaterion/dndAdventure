// ignore_for_file: avoid_print

import 'dart:async';

import 'package:dnd_adventure/game/dnd_adventure.dart';
import 'package:dnd_adventure/game/actors/player.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World with HasGameRef<DnDAdventure> {
  late final String levelName;
  Level({required this.levelName});
  late TiledComponent level;

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load("$levelName.tmx", Vector2.all(32));

    add(level);

    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>("Spawnpunkte");
    for (final spawnPoint in spawnPointsLayer!.objects) {
      switch (spawnPoint.class_) {
        case 'PlayerSpawn':
          final player = Player(
              character: "dummie",
              position: Vector2(spawnPoint.x, spawnPoint.y));
          add(player);
          gameRef.cam.follow(player);

          print("Player spawned at ${player.position}");

          break;
        default:
      }
    }

    return super.onLoad();
  }
}
