import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class UploadItemImage extends StatefulWidget {
  UploadItemImage(this.imagePickFn);
  final void Function(File pickedImage) imagePickFn;
  @override
  _UploadItemImageState createState() => _UploadItemImageState();
}

class _UploadItemImageState extends State<UploadItemImage> {
  File? _pickedImage ;
  final ImagePicker _picker = ImagePicker();

  void _pickImage() async{
      // NOT running on the web! You can check for additional platforms here.
      final pickedImageFile = await _picker.pickImage(source: ImageSource.gallery,);

      setState(() {

        _pickedImage = File(pickedImageFile!.path);
      });
      widget.imagePickFn(_pickedImage! as File);

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.8,
          height: MediaQuery.of(context).size.height*0.25,
          decoration: BoxDecoration(
            image: _pickedImage != null ? DecorationImage(
              image: FileImage(_pickedImage! as File),
              fit: BoxFit.cover,
          ) : null ,
        ),
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image , color: Color(0xFF9C0000) ,),
          label: Text('اضافة صورة', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),),
      ],
    );
  }
}
