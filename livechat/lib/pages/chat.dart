import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  final String username;

  Chat(this.username);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Map<String, dynamic>> messages = [];
  TextEditingController messageController = TextEditingController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _getMessages();
    // Start the timer to fetch new messages every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _getMessages();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  Future<void> _getMessages() async {
    Uri url = Uri.parse('https://0f72-89-114-76-126.ngrok-free.app');
    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        // Parse the response body
        List<dynamic> messageList = json.decode(response.body);
        // Update the state with the retrieved messages
        setState(() {
          messages = List<Map<String, dynamic>>.from(messageList);
        });
      } else {
        print('Failed to fetch messages: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

Future<void> _sendMessage(String message) async {
  // Construct the message data to be sent to the server
  /*var messageData = {
    'nome': widget.username,
    'content': message,
  };*/



  // Define the URL of your server's enviar endpoint
  var url = Uri.parse('https://0f72-89-114-76-126.ngrok-free.app/enviar');

  try {

    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String json = encoder.convert({
      'nome': widget.username,
      'content': message,
    });

    
    var response = await http.post(url, body: json, headers: {
      'Content-Type': 'application/json',
    });

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Handle successful response (optional)
      print('Message sent successfully');
    } else {
      // Handle unsuccessful response
      print('Failed to send message: ${response.reasonPhrase}');
    }
  } catch (e) {
    // Handle any errors that occur during the request
    print('Error sending message: $e');
  }
}
  
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                // Get the message at the current index
                Map<String, dynamic> message = messages[index];
                // Extract the username and message content from the message
                String username = message['nome'];
                String content = message['content'];
                // Return a ListTile to display the message
                return ListTile(
                  title: Text(username),
                  subtitle: Text(content),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                    onSubmitted: (message) {
                      _sendMessage(message);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String message = messageController.text.trim();
                    if (message.isNotEmpty) {
                      _sendMessage(message);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
