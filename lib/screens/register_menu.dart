import 'package:dnd_adventure/screens/login_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dnd_adventure/domain/providers/nakama_provider.dart';
import 'package:dnd_adventure/domain/providers/providers.dart';

class RegisterMenu extends ConsumerWidget {
  const RegisterMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String email = '';
    String username = '';
    String password = '';
    String repeatPassword = '';

    NakamaProvider nakamaProvider = ref.watch(Providers.nakamaProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0),
                child: Text("Register Page")),
            const SizedBox(height: 5.0),
            // Email
            SizedBox(
              width: 300.0, // Set the desired width for the text fields
              child: TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            // Username
            SizedBox(
              width: 300.0, // Set the desired width for the text fields
              child: TextField(
                maxLength: 20,
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
            // Password
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
            const SizedBox(height: 5.0),
            // Repeat Password
            SizedBox(
              width: 300.0, // Set the desired width for the text fields
              child: TextField(
                onChanged: (value) {
                  repeatPassword = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Repeat Password',
                ),
              ),
            ),

            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () async {
                // check if any field is empty
                if (email.isEmpty ||
                    username.isEmpty ||
                    password.isEmpty ||
                    repeatPassword.isEmpty) {
                  // Handle error
                  debugPrint('Empty field');
                  return;
                }

                if (password != repeatPassword) {
                  // Passwords don't match, handle error
                  debugPrint('Passwords don\'t match');
                  return;
                }

                try {
                  // Register the user

                  nakamaProvider.registerNewUser(
                    email: email,
                    password: password,
                    username: username,
                  );

                  // Navigate to login menu after successful registration
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginMenu()));
                } catch (e) {
                  // Handle registration error
                  debugPrint('Error registering user: $e');
                }
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
