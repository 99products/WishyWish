import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wishywish/routes/wishy_route_delegate.dart';
import 'package:wishywish/routes/wishy_route_information_parser.dart';
import 'firebase_options.dart';

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
    return MaterialApp.router(
      title: 'Wishy Wish',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'PTSans',
        primarySwatch: Colors.blue,
      ),
      routerDelegate: WishyRouterDelegate(),
      routeInformationParser: WishyRouteInformationParser(),
    );
  }
}
