import 'package:flutter/material.dart';
import 'package:metham/toManger/file_to_manger.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);
  final bool isLoading;
  final void Function(
      String password,
      String userName,
      String phoneNumber,
      String city,
      String agentName,
      bool isLogin,
      BuildContext ctx,
      ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userName = '';
  String _userPassword = '';
  String _phoneNumber = '';
  String _city='';
  String _AgentName = '';

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if (isValid!) {
      _formKey.currentState?.save();
      // Use those value to send our auth request ...
      widget.submitFn(
        _userPassword.trim(),
        _userName.trim(),
        _phoneNumber.trim(),
        _city.trim(),
        _AgentName.trim(),
        _isLogin,
        context,
      );
    }
  }

  void manger(){
    showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) {
      return MangerToScreen();

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('images/meth.jpg'),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                  ),
                  elevation: 50,
                  margin: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            if (!_isLogin)
                              TextFormField(
                                key: ValueKey('username'),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 9) {
                                    return 'ادخل الاسم بشكل صحيح';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _userName = value!;
                                },
                                decoration: InputDecoration(
                                    labelText: 'اسم الثلاثي و اللقب',
                                  labelStyle: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFF9C0000)), // Change the color of the underline
                                  ),

                                ),
                              ),
                              TextFormField(
                                key: ValueKey('phonenumber'),
                                validator: (value) {
                                  if (value!.isEmpty || value.length<11  || value.length>11 ) {
                                    return 'ادخل الرقم بشكل صحيح';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _phoneNumber = value!;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: 'رقم الهاتف',
                                  labelStyle: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFF9C0000)), // Change the color of the underline
                                  ),
                                ),
                              ),
                            if (!_isLogin)
                            TextFormField(
                              key: ValueKey('city'),
                              validator: (value) {
                                if (value!.isEmpty || value.length <3) {
                                  return 'ادخل المحافظة';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _city = value!;
                              },

                              decoration: InputDecoration(
                                  labelText: 'المحافظة',
                                labelStyle: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF9C0000)), // Change the color of the underline
                                ),
                              ),
                            ),
                            if (!_isLogin)
                              TextFormField(
                                key: ValueKey('Agent name'),
                                validator: (value) {
                                  if (value!.isEmpty || value.length<3 ) {
                                    return 'ادخل اسم الوكيل';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _AgentName = value!;
                                },

                                decoration: InputDecoration(
                                    labelText: 'اسم الوكيل',
                                  labelStyle: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFF9C0000)), // Change the color of the underline
                                  ),
                                ),
                              ),
                            TextFormField(
                              cursorColor: Color(0xFF9C0000),
                              key: ValueKey('password'),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 7) {
                                  return 'ادخل رمز لا يقل عن 7 ارقام';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _userPassword = value!;
                              },
                              decoration: InputDecoration(
                                labelText: 'كلمة المرور',
                                labelStyle: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF9C0000)), // Change the color of the underline
                                ),

                              ),
                              obscureText: true,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width*0.031,
                            ),
                            if (widget.isLoading)
                              CircularProgressIndicator(),
                            if (!widget.isLoading)
                              ElevatedButton(
                                  onPressed: _trySubmit,
                                  child: Text(_isLogin ? 'تسجيل الدخول' : 'اشتراك',style: TextStyle(fontFamily: 'Cairo'),),
                                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF9C0000)),
                              ),
                            if (!widget.isLoading)
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isLogin = !_isLogin;
                                    });
                                  },
                                  child: Text(_isLogin
                                      ? 'انشاء حساب جديد'
                                      : 'لدي حساب', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),
                              ),
                            TextButton(onPressed: manger, child: Text('الادارة', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo')))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
