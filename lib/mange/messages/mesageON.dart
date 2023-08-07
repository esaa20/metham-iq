import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Onmeassge extends StatelessWidget {
  const Onmeassge({Key? key}) : super(key: key);

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
                return ListView.builder(

                  itemCount: meassgeSnapshot.data!.docs.length,
                    itemBuilder: (ctx, index){
                    return Card(
                      elevation: 20,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(mesDocs[index]['text'], style: TextStyle(fontFamily: 'Cairo', color: Color(0xFF9C0000)),),
                            ),
                          ),
                          IconButton(onPressed: (){
                            DocumentReference<Map<String, dynamic>>
                            documentRef =
                            FirebaseFirestore.instance.collection('meassge').doc(mesDocs[index].id);
                            documentRef.delete();
                          }, icon: Icon(Icons.delete , size: 20, color: Color(0xFF9C0000),))
                        ],
                      ),
                    );
                    }
                );
              }
          );
        }, future: null,
    );
  }
}

