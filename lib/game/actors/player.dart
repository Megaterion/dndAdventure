import 'dart:async';

import 'package:dnd_adventure/game/level/levelCollider.dart';
import 'package:dnd_adventure/game/dnd_adventure.dart';
import 'package:dnd_adventure/game/utils.dart';
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

  final double stepTime = 0.15; // Zeit zwischen den einzelnen Animations-Frames
  String facing = "down";

  double horizontalMovement = 0;
  double verticalMovement = 0;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();

  List<LevelCollider> colliders = [];

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();

    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerState();
    _movePlayer(dt, moveSpeed);
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

  void _movePlayer(double dt, double moveSpeed) {
    velocity.x = horizontalMovement;
    velocity.y = verticalMovement;

    // Überprüfe, ob die Geschwindigkeit diagonal ist
    if (velocity.x != 0 && velocity.y != 0) {
      // Normalisiere die Geschwindigkeit, um sicherzustellen, dass sie nicht über den Grenzwert hinausgeht
      double length = velocity.length;
      if (length > 1.0) {
        velocity /= length;
      }
    }

    position.x += velocity.x * moveSpeed * dt;
    _checkForCollisions("horizontal");
    position.y += velocity.y * moveSpeed * dt;
    _checkForCollisions("vertical");
  }

  // Spieler soll nicht durch die Wand laufen können
  void _checkForCollisions(String direction) {
    for (final collider in colliders) {
      if (checkCollision(this, collider)) {
        switch (collider.type) {
          case "pyramid":
            break;
          default:
            if (direction == "horizontal") {
              if (velocity.x > 0) {
                position.x = collider.position.x - size.x;
              } else if (velocity.x < 0) {
                position.x = collider.position.x + collider.size.x;
              }
            }
            if (direction == "vertical") {
              if (velocity.y > 0) {
                position.y = collider.position.y - size.y;
              } else if (velocity.y < 0) {
                position.y = collider.position.y + collider.size.y;
              }
            }
            break;
        }
      }
    }
  }
}
