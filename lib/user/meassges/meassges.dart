import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MeassgesUser extends StatefulWidget {
  MeassgesUser({
    required this.agent
});
  String agent;

  @override
  _MeassgesUserState createState() => _MeassgesUserState();
}

class _MeassgesUserState extends State<MeassgesUser> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (ctx,futureSnapshot){
          if(futureSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return StreamBuilder(
              stream:  FirebaseFirestore.instance.collection('meassge').orderBy('createdAt',descending: true).snapshots(),
              builder: (ctx, meassgeSnapshot){
                if (meassgeSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final mesDocs = meassgeSnapshot.data!.docs;
                return Scaffold(
                  appBar: AppBar(
                    title: Text('الاشعارات',style: TextStyle(fontFamily: 'Cairo',),),
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
                  body: widget.agent == '1'? ListView.builder(

                      itemCount: meassgeSnapshot.data!.docs.length,
                      itemBuilder: (ctx, index){
                        return Card(
                          elevation: 20,
                          child: Container(
                            child: Text(mesDocs[index]['text'],style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),),
                          ),
                        );
                      }
                  ):ListView.builder(

                      itemCount: meassgeSnapshot.data!.docs.length,
                      itemBuilder: (ctx, index){
                        return mesDocs[index]['Agent'] == '0' ?
                        Card(
                          elevation: 20,
                          child: Container(
                            child: Text(mesDocs[index]['text'],style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),),
                          ),
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
