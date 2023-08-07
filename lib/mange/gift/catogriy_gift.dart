import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:metham/mange/gift/gift.dart';


class catogriyGift extends StatelessWidget {
  const catogriyGift({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (ctx,futureSnapshot){
          if(futureSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('gift').snapshots(),
              builder: (ctx, catogrySnapshot){
                if (catogrySnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final catoryDocs = catogrySnapshot.data!.docs;

                return ListView.builder(
                    padding: const EdgeInsets.all(25),
                    itemCount: catogrySnapshot.data!.docs.length,
                    itemBuilder: (ctx, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height*0.15,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                                child: Image.network(catoryDocs[index]['image'], fit: BoxFit.cover,)),

                          ),
                          Container(
                            height: MediaQuery.of(context).size.height*0.15,
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Gift(catogryName: catoryDocs[index].id,),));
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                child: Center(
                                  child: Text(catoryDocs[index].id, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Cairo', color: Color(0xFF9C0000)), ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black12,
                                      Colors.grey
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  );

              }
          );
        }, future: null,
    );
  }
}
