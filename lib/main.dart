import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double start = 0;

  var cardWidgets = List<CardWidget>.empty(growable: true);

  Widget dragArea() {
    return Stack(
      // 2.
      // key: stackKey, // 3.
      fit: StackFit.expand,
      children: cardList(),
    );
  }

  List<Widget> cardList() {
    List<Widget> cards = List<Widget>.empty(growable: true);

    if (cardWidgets.isEmpty) {
      prefillCards();
    }

    for (int i = 0; i < cardWidgets.length; i++) {
      CardWidget cardWidget = cardWidgets[i];
      cards.add(Positioned(
        left: cardWidget._x,
        top: cardWidget._y,
        child: Draggable(
          feedback: cardWidget,
          childWhenDragging: Container(),
          onDragEnd: (dragDetails) {
            setState(() {
              cardWidget._x = dragDetails.offset.dx;
              cardWidget._y = dragDetails.offset.dy;
            });
          },
          child: cardWidget,
        ),
      ));
    }
    return cards;
  }

  prefillCards() {
    cardWidgets = List<CardWidget>.empty(growable: true);
    start = 0;
    for (int i = 0; i < 5; i++) {
      CardWidget cardWidget = CardWidget();
      cardWidget._x = cardWidget._x + start;
      cardWidget._y = 0;
      start = start + 50;
      cardWidgets.add(cardWidget);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: dragArea(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CardWidget extends StatelessWidget {
  var _x = 0.0;
  var _y = 0.0;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            width: 100,
            height: 100,
            child: Column(children: [
              Text('Hii'),
              IconButton(onPressed: () {}, icon: Icon(Icons.add))
            ])));
  }
}
