import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ScoreForm extends StatefulWidget {
  ScoreForm(this.submitFn, this.userScore);
  final void Function(
      String Number,
      String scoreTo,
      BuildContext ctx
      ) submitFn;
  int userScore;
  @override
  _ScoreFormState createState() => _ScoreFormState();
}

class _ScoreFormState extends State<ScoreForm> {
  final _formKey = GlobalKey<FormState>();
  String _numberphone = '';
  String _score = '';

  dynamic showDialog(){
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: 'تمت عملية التحويل بنجاح',
    );
  }
  dynamic showDialogcros(){
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      text: 'هنالك مشكلة',
    );
  }
  void _trySubmit(){
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if(isValid!){
      _formKey.currentState?.save();
      // Use those value to send our auth request ...
      widget.submitFn(
          _numberphone.trim(),
          _score.trim() ,
          context
      );
    }
    if(check){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {showDialog();});
      Navigator.of(context).pop();
    }
    if(check == false){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {showDialogcros();});
      Navigator.of(context).pop();
    }

  }
  bool check = true;
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
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  height: MediaQuery.of(context).size.height*0.012,
                  decoration: BoxDecoration(
                      color: Color(0xFF9C0000),
                      borderRadius: BorderRadius.circular(30),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.015,),
                TextFormField(
                  key: ValueKey('Number Phone'),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Error';
                    }
                    return null ;
                  },
                  onSaved: (value){
                    _numberphone = value! ;
                  },
                  decoration: InputDecoration(
                      labelText: 'رقم الهاتف',
                    labelStyle: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9C0000)), // Change the color of the underline
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  key: ValueKey('Score'),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Error';
                    }
                    return null ;
                  },
                  onSaved: (value){
                    if(int.parse(value!) < 0 || widget.userScore <= 0){
                      _score = '0' ;
                      check = false ;
                      // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {showDialogcros();});
                      // Navigator.pop(context);
                    }
                    else{
                      _score = value! ;
                    }

                  },
                  decoration: InputDecoration(
                      labelText: 'النقاط',
                    labelStyle: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9C0000)), // Change the color of the underline
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.015,),
                Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: ElevatedButton(onPressed: _trySubmit,
                      child: Text('ارسال', style: TextStyle(fontFamily: 'Cairo'),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF9C0000),
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
