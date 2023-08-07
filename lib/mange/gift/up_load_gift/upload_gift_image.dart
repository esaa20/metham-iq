import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UploadGiftImage extends StatefulWidget {
  UploadGiftImage(this.imagePickFn);
  final void Function(File pickedImage) imagePickFn;
  @override
  _UploadGiftImageState createState() => _UploadGiftImageState();
}

class _UploadGiftImageState extends State<UploadGiftImage> {
  File? _pickedImage ;
  final ImagePicker _picker = ImagePicker();
  void _pickImage() async{
    final pickedImageFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100, maxWidth: 150 );
    setState(() {
      _pickedImage = File(pickedImageFile!.path) ;
    });
    widget.imagePickFn(_pickedImage!);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            image: _pickedImage != null ? DecorationImage(
              image: FileImage(_pickedImage!),
              fit: BoxFit.cover,
            ) : null ,
          ),
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),),
      ],
    );
  }
}
