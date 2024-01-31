import 'package:dnd_adventure/screens/login_menu.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  // Setzt die App in den Fullscreen-Modus und erzwingt die Landscape-Orientierung bei Mobilgeräten
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  runApp(
    ProviderScope(
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
        home: const LoginMenu()
      )
    )
  );
}
