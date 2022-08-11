import 'package:flutter/material.dart';
import 'widgets/groupcard_sample_board.dart';
import 'widgets/welcome_banner.dart';

class WelcomePage extends StatelessWidget {
  final Function onClick;
  const WelcomePage({Key? key, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: LayoutBuilder(
          builder: ((context, constraints) => SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                    Container(
                      height: 60,
                      color: Colors.blue,
                    ),
                    WelcomeBanner(
                        maxHeight: constraints.maxHeight, onClick: onClick),
                    GroupCardSampleBoard(),
                  ])))),
    );
  }
}
