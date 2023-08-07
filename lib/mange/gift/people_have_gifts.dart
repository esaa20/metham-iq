import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class UserShowGift extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (ctx,futureSnapshot){
          if(futureSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('usergift').snapshots(),
              builder: (ctx,userSnapshot){
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final userDocs = userSnapshot.data!.docs;
                return Scaffold(
                  appBar: AppBar(
                    title: Text('الاشخاص الذين حصلوا على هداية',style: TextStyle(fontFamily: 'Cairo',),),
                    backgroundColor: Colors.transparent,
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
                  body: ListView.builder(
                      itemCount: userSnapshot.data!.docs.length,
                      itemBuilder: (ctx, index){
                        Timestamp timestamp = userDocs[index]['Time'] as Timestamp;
                        DateTime dateTime = timestamp.toDate();

                        String formattedTime = DateFormat('yyyy-MM-dd-HH').format(dateTime);
                        return  Container(
                            padding: EdgeInsets.all(12),
                            child: Card(
                                elevation: 5.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                          child: Row(
                                            children: [
                                              Icon(Icons.person),
                                              SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                                              Text(userDocs[index]['nameUser'],style: TextStyle(fontFamily: 'Cairo',),),
                                            ],
                                          ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          children: [
                                            Icon(Icons.card_giftcard),
                                            SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                                            Text(userDocs[index]['giftName'],style: TextStyle(fontFamily: 'Cairo',),),
                                          ],
                                        ),
                                      ),
                                      Text(formattedTime),
                                    ],
                                  ),
                                )
                            )
                        );

                      }

                  ),
                );
              }
          );
        }, future: null,
    );
  }
}


