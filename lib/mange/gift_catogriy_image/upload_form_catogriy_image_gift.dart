import 'package:flutter/material.dart';
import 'package:metham/mange/gift_catogriy_image/image_gift_show/image_gift_show.dart';

import 'package:metham/mange/upload_item/upload_image.dart';
import 'dart:io';


import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class UploadFormCatogriyImageGift extends StatefulWidget {
  UploadFormCatogriyImageGift(this.submitFn);
  final void Function(
      String caGiName,
      File caGiImage,
      BuildContext ctx
      ) submitFn;

  @override
  _UploadFormCatogriyImageGiftState createState() => _UploadFormCatogriyImageGiftState();
}

class _UploadFormCatogriyImageGiftState extends State<UploadFormCatogriyImageGift> {
  final _formKey = GlobalKey<FormState>();
  String _caGiName ='';
  File? _image;
  void _pickedImage(File image){
    _image = image ;
  }
  dynamic showDialog(){
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: 'هل انت متأكد!',
    );
  }
  void _trySubmit(){
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if(isValid!){
      _formKey.currentState?.save();
      // Use those value to send our auth request ...
      widget.submitFn(
          _caGiName.trim(),
          _image!,
          context
      );
    }
    if(_caGiName.isNotEmpty){
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
                  key: ValueKey('Name Gift'),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Error';
                    }
                    return null ;
                  },
                  onSaved: (value){
                    _caGiName = value! ;
                  },
                  decoration: InputDecoration(
                    labelText: 'ادخل اسم الصنف',
                    labelStyle: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9C0000)), // Change the color of the underline
                    ),
                  ),
                ),
                SizedBox(height: 12,),
                Container(
                  width: MediaQuery.of(context).size.width*0.6,
                  child: ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text('تحميل', style: TextStyle(color:Colors.grey[200] , fontFamily: 'Cairo'),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xFF9C0000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.6,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> ImageGift()));
                    },
                    child: Text('صور اصناف الهداية', style: TextStyle(color:Colors.grey[200] , fontFamily: 'Cairo'),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xFF9C0000),
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
