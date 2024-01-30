import 'package:dnd_adventure/game/dnd_adventure.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

DnDAdventure _game = DnDAdventure();

class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: kDebugMode ? DnDAdventure() : _game);
  }
}
