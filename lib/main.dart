import 'package:dnd_adventure/game/dnd_adventure.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://ubqnjydrmzwprvmrzgyh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVicW5qeWRybXp3cHJ2bXJ6Z3loIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU3ODQ1NjUsImV4cCI6MjAyMTM2MDU2NX0.cDwFtHGm6uEWRpb9CzGc1Rdzgectai-blnccMXi17n4',
  );

  // Setzt die App in den Fullscreen-Modus und erzwingt die Landscape-Orientierung bei Mobilgeräten
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  // Initialisiert Firebase

  DnDAdventure game = DnDAdventure();
  runApp(GameWidget(game: kDebugMode ? DnDAdventure() : game));
}

final supabase = Supabase.instance.client;
