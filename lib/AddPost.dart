import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:wishywish/common.dart';

class AddPost extends StatefulWidget {
  InputMode INPUT_MODE = InputMode.IMAGE;
  PickedFile? pickedImage;
  TextEditingController textEditingController = new TextEditingController();
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

enum InputMode { IMAGE, GIF, VIDEO }

class AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          TextField(
              maxLines: 10,
              maxLength: 250,
              controller: widget.textEditingController,
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
              ))
        ],
      ),
    );
  }

  Widget addControls() {
    return ButtonBar(
      alignment: MainAxisAlignment.start,
      // buttonPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      children: [
        ElevatedButton(
          child: Text("Add Image"),
          onPressed: () {
            pickImage();
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

  Widget showOrHideFileInputs() {
    return Container(
        child: widget.pickedImage != null
            ? Image.network(
                widget.pickedImage!.path,
                width: 400,
                fit: BoxFit.fitWidth,
              )
            : SizedBox(
                width: 10,
              ));
  }
}
