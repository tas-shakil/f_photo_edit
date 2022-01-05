import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;

class FilterScreen extends StatefulWidget{
  final XFile image;
  const FilterScreen({Key? key,required this.image}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  String? fileName;
  List<Filter> filters = presetFiltersList;
  File? imageFile;


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    throw UnimplementedError();
  }
}