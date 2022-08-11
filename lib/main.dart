import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wishywish/Pages/PostPage/addpost_page.dart';
import 'package:wishywish/Pages/HomePage/myhome_page.dart';
import 'firebase_options.dart';
import 'Pages/WelcomePage/welcome_page.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wishy Wish',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'PTSans',
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => AddPost(),
          '/wishyboard': (context) => const MyHomePage(),
        });
  }
}
