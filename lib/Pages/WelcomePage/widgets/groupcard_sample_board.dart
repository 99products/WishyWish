import 'package:flutter/material.dart';

class GroupCardSampleBoard extends StatelessWidget {
  final List<String> images = [
    "images/birthday-background.png",
    "images/farewell-background.png",
    "images/get-well-soon-background.png",
    "images/promotion-background.png",
    "images/retirement-background.png"
  ];
  final List<String> titleArr = [
    "Birthday",
    "Farewell",
    "Get Well Soon",
    "Promotion",
    "Retirement"
  ];

  GroupCardSampleBoard({Key? key}) : super(key: key);

  Widget galleryCard(String image, String title) {
    return Container(
        height: 200,
        width: 360,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Container(
          margin: const EdgeInsets.all(40.0),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                spreadRadius: 10,
                color: Colors.black.withOpacity(0.2),
                blurRadius: 30,
                offset: const Offset(0, 5))
          ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      primary: Colors.blue.shade600,
                      fixedSize: const Size(100, 30),
                      padding: const EdgeInsets.all(10)),
                  child: const Text(
                    "View",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    //Code Here
                  },
                ),
              ],
            ),
          ),
        ));
  }

  List<Widget> generateGalleryCardGroup() {
    List<Widget> list = [];
    for (var i = 0; i < images.length; i++) {
      list.add(galleryCard(images[i], titleArr[i]));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              textAlign: TextAlign.center,
              "Some sample WishyBoard group card to inspire you",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            spacing: 30.0,
            runSpacing: 30.0,
            children: generateGalleryCardGroup(),
          ),
        ],
      ),
    );
  }
}
