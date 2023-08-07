import 'package:flutter/material.dart';
import 'package:metham/mange/upload_item/upload_image.dart';
import 'dart:io';


import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class UploadForm extends StatefulWidget {
  UploadForm(this.submitFn);
  final void Function(
      String itemName,
      String discItem,
      String kindItem,
      File itemImage,
      BuildContext ctx
      ) submitFn;

  @override
  _UploadFormState createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  final _formKey = GlobalKey<FormState>();
  String _itemName ='';
  String _discItem = '';
  String _kindItem = '' ;
  File? _image;
  void _pickedImage(File image){
    _image = image ;
  }
  dynamic showDialog(){
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: 'هل انت تأكد!',
    );
  }
  void _trySubmit(){
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if(isValid!){
      _formKey.currentState?.save();
      // Use those value to send our auth request ...
      widget.submitFn(
          _itemName.trim(),
          _discItem.trim(),
          _kindItem.trim(),
          _image!,
          context
      );
    }
    if(_itemName.isNotEmpty && _discItem.isNotEmpty && _kindItem.isNotEmpty){
     // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {showDialog();});
      Navigator.of(context).pop();
    }

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UploadItemImage(_pickedImage),
                TextFormField(
                  key: ValueKey('Kind Item'),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Error';
                    }
                    return null ;
                  },
                  onSaved: (value){
                    _kindItem = value! ;
                  },
                  decoration: InputDecoration(
                    labelText: 'صنف الغرض',
                    labelStyle: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9C0000)), // Change the color of the underline
                    ),
                  ),
                ),
                TextFormField(
                  key: ValueKey('Name Item'),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Error';
                    }
                    return null ;
                  },
                  onSaved: (value){
                    _itemName = value! ;
                  },
                  decoration: InputDecoration(
                      labelText: 'اسم الغرض',
                    labelStyle: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9C0000)), // Change the color of the underline
                    ),
                  ),
                ),

                TextFormField(
                  key: ValueKey('Disc Item'),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Error';
                    }
                    return null ;
                  },
                  onSaved: (value){
                    _discItem = value! ;
                  },
                  decoration: InputDecoration(
                      labelText: 'وصف',
                    labelStyle: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9C0000)), // Change the color of the underline
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: ElevatedButton(
                    onPressed: _trySubmit,
                      child: Text('ارسال', style: TextStyle(color: Colors.grey[50], fontFamily: 'Cairo'),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF9C0000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
