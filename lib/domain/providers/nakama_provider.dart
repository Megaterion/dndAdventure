import 'package:dnd_adventure/services/nakama_service.dart';
import 'package:flutter/material.dart';
import 'package:nakama/nakama.dart';

class NakamaProvider extends ChangeNotifier {
  final NakamaService _nakamaService = NakamaService();

  Session? _session;

  NakamaProvider() {
    debugPrint("NakamaProvider initialized");
  }

   Future registerNewUser({
    required String email,
    required String password,
    required String username,
  }) async {
    Session session = await _nakamaService.nakamaAuth.registerNewUser(
      email: email,
      password: password,
      username: username,
    );

    _session = session;
  }

  void loginUser({
    required String username,
    required String password
  }) async {
    Session session = await _nakamaService.nakamaAuth.loginUser(
      username: username,
      password: password,
    );

    _session = session;
  }
}
