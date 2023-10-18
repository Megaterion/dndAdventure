import 'dart:async';

import 'package:dnd_adventure/dnd_adventure.dart';
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

enum PlayerDirection { left, right, up, down, none }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<DnDAdventure>, KeyboardHandler {
  String character;
  Player({
    position,
    required this.character,
  }) : super(position: position);

  late final SpriteAnimation idleDownAnimation;
  late final SpriteAnimation idleUpAnimation;
  late final SpriteAnimation idleLeftAnimation;
  late final SpriteAnimation idleRightAnimation;

  late final SpriteAnimation walkLeftAnimation;
  late final SpriteAnimation walkRightAnimation;
  late final SpriteAnimation walkUpAnimation;
  late final SpriteAnimation walkDownAnimation;

  final double stepTime = 0.05;

  PlayerDirection playerDirection = PlayerDirection.down;
  double movespeed = 100;
  Vector2 velocity = Vector2.zero();

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isDownKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyS);
    final isUpKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyW);
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD);

    if (isLeftKeyPressed && isRightKeyPressed) {
      playerDirection = PlayerDirection.none;
    } else if (isUpKeyPressed && isDownKeyPressed) {
      playerDirection = PlayerDirection.none;
    } else if (isLeftKeyPressed) {
      playerDirection = PlayerDirection.left;
    } else if (isRightKeyPressed) {
      playerDirection = PlayerDirection.right;
    } else if (isUpKeyPressed) {
      playerDirection = PlayerDirection.up;
    } else if (isDownKeyPressed) {
      playerDirection = PlayerDirection.down;
    } else {
      playerDirection = PlayerDirection.none;
    }

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

    // Enthällt alle Animationen
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
    //current = PlayerState.idleDown;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('character/$character/$state.png'),
        SpriteAnimationData.sequenced(
            amount: amount, textureSize: Vector2(64, 64), stepTime: stepTime));
  }

  void _updatePlayerMovement(double dt) {
    double dirX = 0.0;
    double dirY = 0.0;
    String facing = "";

    switch (playerDirection) {
      case PlayerDirection.left:
        dirX -= movespeed;
        facing = "left";
        current = PlayerState.walkingLeft;
        break;
      case PlayerDirection.right:
        dirX += movespeed;
        facing = "right";
        current = PlayerState.walkingRight;
        break;
      case PlayerDirection.up:
        dirY -= movespeed;
        facing = "up";
        current = PlayerState.walkingUp;
        break;
      case PlayerDirection.down:
        dirY += movespeed;
        facing = "down";
        current = PlayerState.walkingDown;
        break;
      case PlayerDirection.none:
        // Setzt die Idle-Animation, basierend auf der letzten Richtung, in die der Spieler gegangen ist
        switch (facing) {
          case "left":
            current = PlayerState.idleLeft;
            break;
          case "right":
            current = PlayerState.idleRight;
            break;
          case "up":
            current = PlayerState.idleUp;
            break;
          case "down":
            current = PlayerState.idleDown;
            break;
          default:
          //current = PlayerState.idleDown;
        }
        break;
      default:
    }

    velocity = Vector2(dirX, dirY);
    position += velocity * dt;
  }
}
