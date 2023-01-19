import 'package:chatapp/screens/pages/chat_page.dart';
import 'package:chatapp/screens/pages/home_page.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      initialRoute: HomePage.route,
      routes: {
        HomePage.route : (context) => HomePage(),
        ChatPage.route : (context) => ChatPage(),
      }
    );
  }
}
