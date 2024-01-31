// ignore_for_file: avoid_print

import 'package:nakama/nakama.dart';

class NakamaService {
  NakamaAuth nakamaAuth = NakamaAuth();

  NakamaService() {
    getNakamaClient(
      host: '127.0.0.1',
      ssl: false,
      serverKey: 'defaultkey',
      httpPort: 7350, // optional
    );
  }
}

class NakamaAuth {
  Future<Session> registerNewUser({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      Session session = await getNakamaClient().authenticateEmail(
        email: email,
        password: password,
        create: true,
        username: username,
      );
      print("Nakama UID: ${session.userId}");
      return session;

    } catch (e) {
      print("Error: $e");
      throw Exception(e);
    }
  }

  Future<Session> loginUser({
    required String username,
    required String password,
  }) async {
    try {
      Session session = await getNakamaClient().authenticateEmail(
        username: username,
        password: password,
      );
      print("Nakama UID: ${session.userId}");
      return session;

    } catch (e) {
      print("Error: $e");
      throw Exception(e);
    }
  }
}
