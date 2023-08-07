import 'package:flutter/material.dart';
import 'package:metham/mange/upload_item/upload_image.dart';
import 'dart:io';


import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class UploadFormCatogriyImage extends StatefulWidget {
  UploadFormCatogriyImage(this.submitFn);
  final void Function(
      String caName,
      File caImage,
      BuildContext ctx
      ) submitFn;

  @override
  _UploadFormCatogriyImageState createState() => _UploadFormCatogriyImageState();
}

class _UploadFormCatogriyImageState extends State<UploadFormCatogriyImage> {
  final _formKey = GlobalKey<FormState>();
  String _caName ='';
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
          _caName.trim(),
          _image!,
          context
      );
    }
    if(_caName.isNotEmpty){
      //WidgetsBinding.instance.addPostFrameCallback((timeStamp) {showDialog();});
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
                    _caName = value! ;
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
