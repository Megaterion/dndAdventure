import 'dart:async';

import 'package:dnd_adventure/game/dnd_adventure.dart';
import 'package:flame/components.dart';
import 'package:flutter/src/services/raw_keyboard.dart';

enum PlayerState {
  idleLeft,
  idleRight,
  idleUp,
  idleDown,
  walkingLeft,
  walkingRight,
  walkingUp,
  walkingDown
}

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<DnDAdventure>, KeyboardHandler {
  String character;
  Player({
    position,
    required this.character,
  }) : super(position: position) {
    debugMode = true;
  }

  late final SpriteAnimation idleDownAnimation;
  late final SpriteAnimation idleUpAnimation;
  late final SpriteAnimation idleLeftAnimation;
  late final SpriteAnimation idleRightAnimation;

  late final SpriteAnimation walkLeftAnimation;
  late final SpriteAnimation walkRightAnimation;
  late final SpriteAnimation walkUpAnimation;
  late final SpriteAnimation walkDownAnimation;

  final double stepTime = 0.15; // Zeit zwischen den einzelnen Frames
  String facing = "down";

  double horizontalMovement = 0;
  double verticalMovement = 0;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();

    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerState();
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalMovement = 0;
    verticalMovement = 0;

    final isDownKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyS);
    final isUpKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyW);
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD);

    horizontalMovement += isLeftKeyPressed ? -1 : 0;
    horizontalMovement += isRightKeyPressed ? 1 : 0;

    verticalMovement += isUpKeyPressed ? -1 : 0;
    verticalMovement += isDownKeyPressed ? 1 : 0;

    return super.onKeyEvent(event, keysPressed);
  }

  void _loadAllAnimations() {
    idleDownAnimation = _spriteAnimation("_idle down", 5);
    idleUpAnimation = _spriteAnimation("_idle up", 5);
    idleLeftAnimation = _spriteAnimation("_idle left", 5);
    idleRightAnimation = _spriteAnimation("_idle right", 5);

    walkLeftAnimation = _spriteAnimation("_walk left", 6);
    walkRightAnimation = _spriteAnimation("_walk right", 6);
    walkUpAnimation = _spriteAnimation("_walk up", 6);
    walkDownAnimation = _spriteAnimation("_walk down", 6);

    // Enthält alle Animationen
    animations = {
      PlayerState.idleDown: idleDownAnimation,
      PlayerState.idleUp: idleUpAnimation,
      PlayerState.idleLeft: idleLeftAnimation,
      PlayerState.idleRight: idleRightAnimation,
      PlayerState.walkingDown: walkDownAnimation,
      PlayerState.walkingUp: walkUpAnimation,
      PlayerState.walkingLeft: walkLeftAnimation,
      PlayerState.walkingRight: walkRightAnimation,
    };

    // Setzt die Animation, die beim Start des Spiels abgespielt werden soll
    current = PlayerState.idleDown;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('character/$character/$state.png'),
        SpriteAnimationData.sequenced(
            amount: amount, textureSize: Vector2(64, 64), stepTime: stepTime));
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idleDown;

    // äbhänging von velocity.x und velocity.y wird die Animation gesetzt
    if (velocity.x < 0) {
      playerState = PlayerState.walkingLeft;
      facing = "left";
    } else if (velocity.x > 0) {
      playerState = PlayerState.walkingRight;
      facing = "right";
    } else if (velocity.y < 0) {
      playerState = PlayerState.walkingUp;
      facing = "up";
    } else if (velocity.y > 0) {
      playerState = PlayerState.walkingDown;
      facing = "down";
    } else {
      switch (facing) {
        case "left":
          playerState = PlayerState.idleLeft;
          break;
        case "right":
          playerState = PlayerState.idleRight;
          break;
        case "up":
          playerState = PlayerState.idleUp;
          break;
        case "down":
          playerState = PlayerState.idleDown;
          break;
      }
    }

    current = playerState;
  }

  void _updatePlayerMovement(double dt) {
    velocity.x = horizontalMovement;
    velocity.y = verticalMovement;

    position += velocity * moveSpeed * dt;
  }
}
