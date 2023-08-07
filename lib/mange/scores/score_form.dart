import 'package:flutter/material.dart';

class ScoreForm extends StatefulWidget {
  ScoreForm(this.submitFn);
  final void Function(
      String scoreTo,
      BuildContext ctx
      ) submitFn;

  @override
  _ScoreFormState createState() => _ScoreFormState();
}

class _ScoreFormState extends State<ScoreForm> {
  final _formKey = GlobalKey<FormState>();
  String _score = '';
  void _trySubmit(){
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if(isValid!){
      _formKey.currentState?.save();
      // Use those value to send our auth request ...
      widget.submitFn(
          _score.trim() ,
          context
      );
    }
    Navigator.of(context).pop();
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
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  height: MediaQuery.of(context).size.height*0.01,
                  decoration: BoxDecoration(
                      color: Color(0xFF9C0000),
                      borderRadius: BorderRadius.circular(30)
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                TextFormField(
                  key: ValueKey('Score'),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Error';
                    }
                    return null ;
                  },
                  onSaved: (value){
                    _score = value! ;
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
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                Container(
                  width: MediaQuery.of(context).size.width*0.7,
                  child: ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text('ارسال', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
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
