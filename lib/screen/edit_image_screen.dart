import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class EditImageScreen extends StatefulWidget {
  final XFile image;
  const EditImageScreen({Key? key, required this.image}) : super(key: key);

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  BuildContext? scaffoldContext;
  File? croptedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Image'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(child: topWidget(widget.image)),
            bottomWidget()
          ],
        ),
        );
  }

  Widget topWidget(XFile getImage) {

    if(croptedImage == null){
      return Image.file(File(
        getImage.path,
      ));
    }else{
      return Image.file(
        croptedImage!,
      );
    }


  }

  Widget bottomWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: const BoxDecoration(color: Colors.black12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.palette_rounded), // icon
                Text("Filter"), // text
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              cropAllImage(widget.image);
            },
            style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.settings_rounded), // icon
                Text("Tools"), // text
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {

            },
            style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.save_rounded), // icon
                Text("Save"), // text
              ],
            ),
          ),
        ],
      ),
    );
  }


  cropAllImage(XFile photo) async{

    File? croppedFile = await ImageCropper.cropImage(
        sourcePath:croptedImage == null?  photo.path : croptedImage!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );

    setState(() {
      croptedImage = croppedFile;
    });


  }
}
