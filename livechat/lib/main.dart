import 'package:flutter/material.dart';
import 'pages/chat.dart';

void main() => runApp(App());

/************ Main App Widget ************/
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horario',
      home: HomePage(),
    );
  }
}

/************ Home Page Widget ************/
class HomePage extends StatelessWidget {
  // Controller for the username text field
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Live Chat'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text field to enter username
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Enter your username',
              ),
            ),
            SizedBox(height: 20),
            // Button to start chatting
            ElevatedButton(
              onPressed: () {
                String username = _usernameController.text;
                // Navigate to the chat page with the entered username
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Chat(username)),
                );
              },
              child: Text('Conversar'),
            ),
          ],
        ),
      ),
    );
  }
}
