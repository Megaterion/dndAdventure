import 'package:dnd_adventure/screens/game_play.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0),
                child: Text("DnD Adventure")),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const GamePlay()));
              },
              child: const Text("Play"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Options"),
            ),
          ],
        ),
      ),
    );
  }
}
