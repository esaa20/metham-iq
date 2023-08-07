import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'info_user.dart';

class UserShow extends StatefulWidget {
  UserShow({
    required this.agent,
});
  String agent;

  @override
  State<UserShow> createState() => _UserShowState();
}

class _UserShowState extends State<UserShow> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (ctx,futureSnapshot){
          if(futureSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (ctx,userSnapshot){
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final userDocs = userSnapshot.data!.docs;
                return Container(
                  child: ListView.builder(
                      itemCount: userSnapshot.data!.docs.length,
                      itemBuilder: (ctx, index){

                        return userDocs[index]['agent'] == widget.agent ?  Container(
                            padding: EdgeInsets.all(12),
                            child: Card(
                                elevation: 5.5,
                                child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                      return InfoUser(
                                        nameUser: userDocs[index]['username'],
                                        emailUser: userDocs[index]['email'],
                                        passworUser: userDocs[index]['password'],
                                        phonUser: userDocs[index]['phonenumber'],
                                        scoreUser: userDocs[index]['score'],
                                        douc: userDocs[index]['userid'],
                                        index: index,
                                        agent: userDocs[index]['Agent name'],
                                      );
                                    }));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerRight,
                                            child: Row(
                                              children: [
                                                Icon(Icons.person),
                                                SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                                                Text(userDocs[index]['username'], style: TextStyle(fontFamily: 'Cairo'),),
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
                                                Text(userDocs[index]['phonenumber'], style: TextStyle(fontFamily: 'Cairo'),),
                                                SizedBox(width: MediaQuery.of(context).size.width*0.399,),
                                                Align(
                                                  alignment: Alignment.bottomLeft,
                                                  child: IconButton(onPressed: (){
                                                    DocumentReference documentRef =
                                                    FirebaseFirestore.instance.collection('users').doc(userDocs[index]['userid']);
                                                    documentRef.update({
                                                      'agent': widget.agent=='1'? '0':'1'
                                                    });
                                                  },
                                                      icon: Icon( widget.agent=='1'? Icons.star :Icons.star_border, color: Color(0xFF9C0000), )),
                                                )
                                              ],
                                            ),
                                        ),

                                      ],
                                    ),
                                  ),
                                )
                            )
                        ):Container();

                      }

                  ),
                );
              }
          );
        }, future: null,
    );
  }
}
