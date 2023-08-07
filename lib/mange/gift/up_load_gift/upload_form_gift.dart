import 'package:flutter/material.dart';
import 'package:metham/mange/upload_item/upload_image.dart';
import 'dart:io';


import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class UploadFormGift extends StatefulWidget {
  UploadFormGift(this.submitFn);
  final void Function(
      String giftName,
      String kindGift,
      String giftScore,
      File giftImage,
      BuildContext ctx
      ) submitFn;

  @override
  _UploadFormGiftState createState() => _UploadFormGiftState();
}

class _UploadFormGiftState extends State<UploadFormGift> {
  final _formKey = GlobalKey<FormState>();
  String _giftName ='';
  String _kindGift = '' ;
  String  _giftScore='';
  File? _image;
  void _pickedImage(File image){
    _image = image ;
  }
  dynamic showDialog(){
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: 'Transaction Completed Successfully!',
    );
  }
  void _trySubmit(){
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if(isValid!){
      _formKey.currentState?.save();
      // Use those value to send our auth request ...
      widget.submitFn(
          _giftName.trim(),
          _kindGift.trim(),
          _giftScore.trim(),
          _image!,
          context
      );
    }
    if(_giftName.isNotEmpty && _kindGift.isNotEmpty){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {showDialog();});
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
                  key: ValueKey('Kind Gift'),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Error';
                    }
                    return null ;
                  },
                  onSaved: (value){
                    _kindGift = value! ;
                  },
                  decoration: InputDecoration(
                      labelText: 'ادخل صنف الهدية',
                    labelStyle: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9C0000)), // Change the color of the underline
                    ),
                  ),
                ),
                TextFormField(
                  key: ValueKey('Name Gift'),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Error';
                    }
                    return null ;
                  },
                  onSaved: (value){
                    _giftName = value! ;
                  },
                  decoration: InputDecoration(
                      labelText: 'ادخل اسم الهدية',
                    labelStyle: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9C0000)), // Change the color of the underline
                    ),
                  ),
                ),
                TextFormField(
                  key: ValueKey('Score Gift'),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Error';
                    }
                    return null ;
                  },
                  onSaved: (value){
                    _giftScore = value! ;
                  },
                  decoration: InputDecoration(
                      labelText: 'ادخل عدد النقاط الهدية',
                    labelStyle: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9C0000)), // Change the color of the underline
                    ),
                  ),
                  keyboardType: TextInputType.number ,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
