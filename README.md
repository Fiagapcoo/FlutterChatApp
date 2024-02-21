# Live Chat App

This is a simple live chat application built with Flutter and a server-side component for handling chat messages.

## Features

- Users can enter their username and start chatting.
- Messages are fetched from the server every 5 seconds to display the latest chat history.
- Users can send messages in real-time.

## Technologies Used

- Flutter: Frontend framework for building the mobile app.
- Dart: Programming language used with Flutter.
- Node.js: Backend server to handle chat messages.
- Express.js: Framework for building the Node.js server.
- MySQL: Database for storing chat messages.

## Installation

1. Clone the repository:

```bash ´´´
git clone <repository-url>
```

2. Navigate to the project directory:
```bash ´´´
cd livechat
```


3. Install dependencies for the Flutter app:
```bash ´´´
flutter pub get
```

4. Install dependencies for the Node.js server:
```bash ´´´
cd backend
npm install
```

5. Create a MySQL database and run the SQL script in `backend/database.sql`

6. Enter your username and start chatting!

## Configuring Server Endpoint

Alter the `livechat/lib/pages/chat.dart` file to point to your server's IP address and port:

Replace the server URL with your server's IP address and port in the following line of code:

```dart
Uri url = Uri.parse('http://your-server-ip-address:your-port');
```




## Usage

1. Start the Node.js server:


2. Run the Flutter app on a device or emulator:


3. Enter your username and start chatting!

## Contributing

Contributions are welcome! Please feel free to open a pull request or submit an issue if you find any bugs or have suggestions for improvements.

## License

This project is licensed under the [MIT License](LICENSE/MIT.txt).

