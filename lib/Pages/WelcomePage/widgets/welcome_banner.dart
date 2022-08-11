import 'package:flutter/material.dart';

class WelcomeBanner extends StatelessWidget {
  final double maxHeight;
  final String welcomeMessage =
      "Make someones memorable day even more memorable with WishyBoard";
  final String caption =
      "Lets start the celebration!!! Create your group card now!!!";
  final Function onClick;

  const WelcomeBanner(
      {Key? key, required this.maxHeight, required this.onClick})
      : super(key: key);

  Widget messageBuilder(String message, double fontSize, FontWeight weight) {
    return SizedBox(
      width: 700,
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: fontSize, fontWeight: weight),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxHeight * 0.4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            messageBuilder(welcomeMessage, 36.0, FontWeight.bold),
            const SizedBox(height: 20.0),
            messageBuilder(caption, 18.0, FontWeight.normal),
            const SizedBox(height: 40.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                primary: Colors.blue.shade600,
                fixedSize: const Size(240, 60),
                padding: const EdgeInsets.all(10),
              ),
              child: const Text(
                "Create a Wishyboard",
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                onClick("wishyboard");
              },
            ),
          ],
        ),
      ),
    );
  }
}
