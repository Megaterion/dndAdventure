import 'package:dnd_adventure/game/dnd_adventure.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  // Setzt die App in den Fullscreen-Modus und erzwingt die Landscape-Orientierung bei Mobilgeräten
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  DnDAdventure game = DnDAdventure();
  runApp(GameWidget(game: kDebugMode ? DnDAdventure() : game));
}
