import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:transparent_image/transparent_image.dart';

class UnSplashImageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UnSplashImageWidgetState();
  }
}

class _UnSplashImageWidgetState extends State<UnSplashImageWidget> {
  TextEditingController _searchController =
      new TextEditingController(text: 'Happy');
  var searchResults = {};
  final client_id = "Ef0Xmfc9-9vcPlOddxedaqbZMlwo5XaO-ExRKSWHDkk";
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      searchControls(),
      searchResults.isNotEmpty
          ? Container(height: 500, child: imageList())
          : SizedBox(
              height: 5,
            )
    ]);
    ;
  }

  Widget imageList() {
    return MasonryGridView.count(
        primary: false,
        crossAxisCount: 2,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        itemCount: searchResults['results'].length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ImageView(
                    //             imgPath: searchResults["results"][index]["urls"]
                    //             ["regular"])));
                  },
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: searchResults["results"][index]["urls"]["thumb"],
                    fit: BoxFit.cover,
                  ),
                ),
              ));
        });
  }

  Widget searchControls() {
    return Row(children: <Widget>[
      Expanded(
        child: TextField(
          controller: _searchController,
          decoration:
              InputDecoration(hintText: 'Search', border: OutlineInputBorder()),
        ),
      ),
      ElevatedButton(
          child: Text('Search'),
          onPressed: () {
            getSearch();
          })
    ]);
  }

  getSearch() async {
    //TODO add pagination
    var url =
        "https://api.unsplash.com/search/photos?per_page=30&query=${_searchController.text}&client_id=$client_id";
    var response = await http.get(Uri.parse(url));
    var converted = json.decode(response.body);
    setState(() {
      searchResults = converted;
    });
  }
}
