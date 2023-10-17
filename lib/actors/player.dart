import 'dart:async';

import 'package:dnd_adventure/dnd_adventure.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

enum PlayerState {
  idle,
  walking,
}

class Player extends SpriteAnimationComponent with HasGameRef<DnDAdventure> {
  String character;
  Player({position, required this.character}) : super(position: position);

  late final SpriteAnimation idleDownAnimation;
  late final SpriteAnimation walkDownAnimation;

  final double stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  void _loadAllAnimations() {
    idleDownAnimation = _spriteAnimation("_idle down", 5);

    // Enthällt alle Animationen
    animations = {
      PlayerState.idle: idleDownAnimation,
      PlayerState.walking: walkDownAnimation,
    };

    // Setzt die Animation, die beim Start des Spiels abgespielt werden soll
    durrent = PlayerState.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('character/$character/$state.png'),
        SpriteAnimationData.sequenced(
            amount: amount, textureSize: Vector2(32, 32), stepTime: stepTime));
  }
}
