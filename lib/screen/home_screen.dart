import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'edit_image_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () {
        getImage(context, ImageSource.gallery);
      },
      child: Container(
        color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                size: 150,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Tap anywhere to open a photo',
                style: TextStyle(fontSize: 20, color: Colors.grey))
          ],
        ),
      ),
    ));
  }

  Future getImage(BuildContext context, ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    // gallery source
    final XFile? photo = await _picker.pickImage(source: source);

    if (photo != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => EditImageScreen(image: photo)));
    }
  }
}
