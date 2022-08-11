import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wishywish/Pages/PostPage/addpost_page.dart';
import 'package:wishywish/common.dart';
import 'package:flutterfire_ui/firestore.dart';
import '../../common.dart';
import 'widgets/add_board_title.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [AddBoardTitle(), Expanded(child: fetchWishes())]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPost()),
          );
        },
        tooltip: 'Add post',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> showPostdialog() async {
    AddPost postDialog = AddPost();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Add a Post',
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          content: postDialog,
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  postDialog.addPost();
                  Navigator.of(context).pop();
                },
                child: Text('Post')),
            InkWell(
              child: Text('Discard Post'),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Widget fetchWishes() {
    return FirestoreQueryBuilder<Map<String, dynamic>>(
      query: FirebaseFirestore.instance
          .collection('wishywish')
          .doc(defaultWish)
          .collection('wishes'),
      child: Text('Loading...'),
      builder: (context, snapshot, _) {
        return MasonryGridView.count(
          crossAxisCount: 4,
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {
            // if we reached the end of the currently obtained items, we try to
            // obtain more items
            if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
              // Tell FirestoreQueryBuilder to try to obtain more items.
              // It is safe to call this function from within the build method.
              snapshot.fetchMore();
            }
            return wishCard(
                snapshot.docs[index].data(), snapshot.docs[index].id);
          },
        );
      },
    );
  }

  Widget wishCard(Map wish, String wishId) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageTile(url: wish['imagePath']),
            const SizedBox(height: 4),
            Padding(
                padding: EdgeInsets.all(
                  10,
                ),
                child: Text(
                  wish['text'],
                  textAlign: TextAlign.start,
                )),
            const SizedBox(height: 4),
            GestureDetector(
              onTapDown: (TapDownDetails details) {
                showWishMenu(details.globalPosition, wishId, wish['imagePath']);
              },
              child: InkWell(
                child: Padding(
                    padding: EdgeInsets.all(
                      10,
                    ),
                    child: Text(
                      '...',
                      textAlign: TextAlign.start,
                    )),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ));
  }

  showWishMenu(Offset position, String wishId, String wishUrl) {
    double left = position.dx;
    double top = position.dy;
    //show menu on button click
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        left,
        top,
        left + 1,
        top + 1,
      ),
      items: [
        PopupMenuItem(
          child: Text('Delete'),
          value: 'delete',
          onTap: () {
            deleteWish(wishId, wishUrl);
          },
        ),
        PopupMenuItem(
          child: Text('Edit'),
          value: 'edit',
        ),
      ],
    );
  }

  void deleteWish(String wishId, String wishUrl) {
    FirebaseFirestore.instance
        .collection('wishywish')
        .doc(defaultWish)
        .collection('wishes')
        .doc(wishId)
        .delete();
    if (wishUrl != null) {
      FirebaseStorage.instance.refFromURL(wishUrl).delete();
    }
  }
}
