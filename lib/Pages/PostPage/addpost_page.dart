import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:wishywish/Pages/PostPage/widgets/unplash_images.dart';
import 'package:wishywish/common.dart';

class AddPost extends StatefulWidget {
  InputMode INPUT_MODE = InputMode.NONE;
  PickedFile? pickedImage;
  TextEditingController textEditingController = new TextEditingController();

  AddPost({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddPostState();
  }

  void addPost() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageRef =
        storage.ref().child('images/${pickedImage!.path.split('/').last}');
    storageRef
        .putData(await pickedImage!.readAsBytes())
        .then((TaskSnapshot snapshot) {
      snapshot.ref.getDownloadURL().then((downloadUrl) {
        //Post to firebase
        FirebaseFirestore db = FirebaseFirestore.instance;
        Map<String, dynamic> data = new Map();
        data['imagePath'] = downloadUrl;
        data['text'] = textEditingController.text;
        db
            .collection('wishywish')
            .doc(defaultWish)
            .collection('wishes')
            .add(data);
      });
    });
  }
}

enum InputMode { NONE, IMAGE, UNSPLASH, GIF, VIDEO }

class AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: body());
  }

  Widget body() {
    return Center(
        child: SingleChildScrollView(
      child: Container(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              addControls(),
              showOrHideFileInputs(),
              SizedBox(
                height: 20,
              ),
              inputText(),
              SizedBox(
                height: 20,
              ),
              bottomControls()
            ],
          )),
    ));
  }

  Widget bottomControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Post'),
        ),
        SizedBox(
          width: 20,
        ),
        TextButton(
          onPressed: () {
            widget.addPost();
            Navigator.pop(context);
          },
          child: Text('Discard'),
        ),
      ],
    );
  }

  Widget inputText() {
    return TextField(
        maxLines: 10,
        maxLength: 250,
        controller: widget.textEditingController,
        decoration: new InputDecoration(
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
        ));
  }

  Widget addControls() {
    return ButtonBar(
      alignment: MainAxisAlignment.start,
      // buttonPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      children: [
        ElevatedButton(
          child: Text("Add Image"),
          onPressed: () {
            unSplash();
          },
        ),
        ElevatedButton(
          child: Text("Add GIF"),
          onPressed: () {},
        ),
        ElevatedButton(
          child: Text("Add Video"),
          onPressed: () {},
        )
      ],
    );
  }

  unSplash() {
    setState(() {
      widget.INPUT_MODE = InputMode.UNSPLASH;
    });
  }

  pickImage() async {
    final ImagePickerPlugin _picker = ImagePickerPlugin();

    PickedFile pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null && pickedFile.path != null) {
      setState(() {
        widget.pickedImage = pickedFile;
        widget.INPUT_MODE = InputMode.IMAGE;
      });
    }
  }

  updateImage(String imagePath) {
    setState(() {
      // widget.pickedImage = imagePath;
      widget.INPUT_MODE = InputMode.IMAGE;
    });
  }

  Widget showOrHideFileInputs() {
    return mediaWidget();
  }

  Widget mediaWidget() {
    if (widget.INPUT_MODE == InputMode.IMAGE) {
      return imageWidget();
    }
    // else if (widget.INPUT_MODE == InputMode.GIF) {
    //   return gifWidget();
    // } else if (widget.INPUT_MODE == InputMode.VIDEO) {
    //   return videoWidget();
    // }
    else if (widget.INPUT_MODE == InputMode.UNSPLASH) {
      return unsplashWidget();
    } else {
      return SizedBox(
        width: 10,
      );
    }
  }

  Widget unsplashWidget() {
    return UnSplashImageWidget();
  }

  Widget imageWidget() {
    return Center(
        child: Image.network(
      widget.pickedImage!.path,
      width: 400,
      fit: BoxFit.fitWidth,
    ));
  }

  //unsplash api and show in staggered grid
  //https://api.unsplash.com/search/photos?query=nature&client_id=Ef0Xmfc9-9vcPlOddxedaqbZMlwo5XaO-ExRKSWHDkk
  void fetchAndShowPics(String query) {
    // String url =
    // "https://api.unsplash.com/search/photos?query=$query&client_id=${unsplashApiKey}";
  }
}
