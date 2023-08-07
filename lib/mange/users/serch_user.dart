import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:metham/mange/users/info_user.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String phone = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Card(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Color(0xFF9C0000),) ,
              labelStyle: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF9C0000)), // Change the color of the underline
              ),
            ),
            onChanged: (val) {
              setState(() {
                phone = val;
              });
            },
            keyboardType: TextInputType.number,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF9C0000), Color(0xFF2E0101)],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshots.data!.docs;
                if(phone.isEmpty){
                  return Container();
                }
                if(data[index]['phonenumber'].toString().startsWith(phone.toUpperCase().toLowerCase())){ // here the function to serch
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                        return InfoUser(
                          nameUser: data[index]['username'],
                          emailUser: data[index]['email'],
                          passworUser: data[index]['password'],
                          phonUser: data[index]['phonenumber'],
                          scoreUser: data[index]['score'],
                          douc: data[index]['userid'],
                          index: index,
                          agent: data[index]['Agent name'],
                        );
                      }));
                    },
                    child: Card(
                      elevation: 4.5,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              children: [
                                Icon(Icons.person),
                                SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                                Text(data[index]['username']),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.015,
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                                Text(data[index]['phonenumber']),
                                SizedBox(width: MediaQuery.of(context).size.width*0.399,),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: IconButton(onPressed: (){
                                    DocumentReference documentRef =
                                    FirebaseFirestore.instance.collection('users').doc(data[index]['userid']);
                                    documentRef.update({
                                      'agent': data[index]['agent']=='1'? '0':'1'
                                    });
                                  },
                                      icon: Icon( data[index]['agent']=='1'? Icons.star :Icons.star_border, color: Color(0xFF9C0000), )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              });
        },
      ),
    );
  }
}
