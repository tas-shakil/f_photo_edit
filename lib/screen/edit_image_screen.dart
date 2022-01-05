import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;

class EditImageScreen extends StatefulWidget {
  final XFile image;
  const EditImageScreen({Key? key, required this.image}) : super(key: key);

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  BuildContext? scaffoldContext;
  String? fileName;
  List<Filter> filters = presetFiltersList;
  File? editedImageFile;

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
            bottomWidget(context)
          ],
        ),
        );
  }

  Widget topWidget(XFile getImage) {
    if(editedImageFile == null){
      return Image.file(File(
        getImage.path,
      ));
    }else{
      return Image.file(
        editedImageFile!,
      );
    }

  }

  Widget bottomWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: const BoxDecoration(color: Colors.black12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              filterImage(context, widget.image);
            },
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

  Future filterImage(BuildContext context, XFile filterImage) async{

    editedImageFile = File(filterImage.path);
    fileName = basename(editedImageFile!.path);
    var image = imageLib.decodeImage(await editedImageFile!.readAsBytes());
    image = imageLib.copyResize(image!, width: 600);

    Map imagefile = await Navigator.push(
      context,
        MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: const Text("Photo Filter Example"),
          image: image!,
          filters: presetFiltersList,
          filename: fileName!,
          loader:const Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );

    if (imagefile.containsKey('image_filtered')) {
      setState(() {
        editedImageFile = imagefile['image_filtered'];
      });
      print(editedImageFile!.path);
    }


  }


  cropAllImage(XFile photo) async{

    File? croppedFile = await ImageCropper.cropImage(
        sourcePath:editedImageFile == null?  photo.path : editedImageFile!.path,
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
      editedImageFile = croppedFile;
    });


  }
}
