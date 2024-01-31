import 'package:dnd_adventure/domain/providers/nakama_provider.dart';
import 'package:dnd_adventure/screens/main_menu.dart';
import 'package:dnd_adventure/screens/register_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dnd_adventure/domain/providers/providers.dart';

class LoginMenu extends ConsumerWidget {
  const LoginMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    String username = '';
    String password = '';

    NakamaProvider nakamaProvider = ref.watch(Providers.nakamaProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0),
                child: Text("Login Page")),
            const SizedBox(height: 5.0),
            SizedBox(
              width: 300.0, // Set the desired width for the text fields
              child: TextField(
                onChanged: (value) {
                  username = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            const SizedBox(height: 5.0),
             SizedBox(
              width: 300.0, // Set the desired width for the text fields
              child: TextField(
                onChanged: (value) {
                  password = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // check if any field is empty
                if (
                    username.isEmpty ||
                    password.isEmpty) {
                  // Handle error
                  debugPrint('Empty field');
                  return;
                }
                
                try {
                  nakamaProvider.loginUser(
                  username: username,
                  password: password,
                  );
                } catch (e) {
                  // Handle registration error
                  debugPrint('Error login user: $e');
                }

                
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const MainMenu()));
              },
              child: const Text("Login"),
            ),
            const SizedBox(height: 30.0),
            const Text("Noch keinen Account?"),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const RegisterMenu()));
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
