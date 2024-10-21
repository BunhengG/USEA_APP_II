import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Handle login logic
                print('Login clicked');
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Handle sign up logic
          print('Sign up clicked');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
