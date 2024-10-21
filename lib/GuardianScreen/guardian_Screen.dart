import 'package:flutter/material.dart';

class GuardianScreen extends StatelessWidget {
  const GuardianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guardian'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Guardian Screen'),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement logic to navigate to the child's screen
                // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => ChildScreen()));
              },
              child: const Text('Open Child Screen'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement logic to open the settings screen
          // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
        },
        child: const Icon(Icons.settings),
      ),
    );
  }
}
