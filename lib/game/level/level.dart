// ignore_for_file: avoid_print

import 'dart:async';

import 'package:dnd_adventure/game/collisionHandler.dart';
import 'package:dnd_adventure/game/dnd_adventure.dart';
import 'package:dnd_adventure/game/actors/player.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World with HasGameRef<DnDAdventure> {
  late final String levelName;
  Level({required this.levelName});
  late TiledComponent level;

  List<CollisionHandler> colliders = [];

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load("$levelName.tmx", Vector2.all(32));

    add(level);

    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>("Spawnpunkte");
    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer.objects) {
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
    }

    final CollisionLayer = level.tileMap.getLayer<ObjectGroup>("Collider");
    if (CollisionLayer != null) {
      for (final collider in CollisionLayer.objects) {
        switch (collider.class_) {
          case 'Pyramid':
            final pyramid = CollisionHandler(
              position: Vector2(collider.x, collider.y),
              size: Vector2(collider.width, collider.height),
              type: "pyramid",
            );
            colliders.add(pyramid);
            add(pyramid);
            break;
          default:
            final defaultCollider = CollisionHandler(
              position: Vector2(collider.x, collider.y),
              size: Vector2(collider.width, collider.height),
            );
            colliders.add(defaultCollider);
            add(defaultCollider);
        }
      }
    }

    return super.onLoad();
  }
}
