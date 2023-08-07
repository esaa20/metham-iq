import 'package:flutter/material.dart';

import '../mange/screens/home_screen.dart';

class MangerForm extends StatefulWidget {
  MangerForm(this.submitFn);
  final void Function(
      String password,
      BuildContext ctx
      ) submitFn;

  @override
  _MangerFormState createState() => _MangerFormState();
}

class _MangerFormState extends State<MangerForm> {
  final _formKey = GlobalKey<FormState>();
  String _Password = '';
  String myPassword = '2002781973';

  void _trySubmit(){
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if(isValid!){
      _formKey.currentState?.save();
      if(_Password == myPassword){
        widget.submitFn(
            _Password.trim(),
            context
        );
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> HomeScreen() ));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final hight= MediaQuery.of(context).size.height;
    final widdth= MediaQuery.of(context).size.width;
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
                  width: widdth*0.255,
                  height: widdth*0.0205,
                  decoration: BoxDecoration(
                      color: Color(0xFF9C0000),
                      borderRadius: BorderRadius.circular(30)
                  ),
                ),
                SizedBox(height: widdth*0.031,),
                TextFormField(
                  key: ValueKey('PassWord'),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Error';
                    }
                    return null ;
                  },
                  onSaved: (value){
                    _Password = value! ;
                  },
                  decoration: InputDecoration(
                      labelText: 'ادخل الرمز',
                    labelStyle: TextStyle(color: Color(0xFF9C0000) , fontFamily: 'Cairo'),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9C0000)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(onPressed: _trySubmit, child: Text('دخول', style: TextStyle(fontFamily: 'Cairo'),),
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF9C0000)),
                )
              ],
            ) ,
          ),
        ),
      ),
    );
  }
}
