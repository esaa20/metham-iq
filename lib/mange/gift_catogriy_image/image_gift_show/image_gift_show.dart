import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImageGift extends StatefulWidget {
  const ImageGift({Key? key}) : super(key: key);

  @override
  _ImageGiftState createState() => _ImageGiftState();
}

class _ImageGiftState extends State<ImageGift> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صور اصناف الهداية', style: TextStyle(fontFamily: 'Cairo'),),
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
      body: FutureBuilder(
        builder: (ctx, futureSnapshot){
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('gift').snapshots(),
              builder: (ctx, imgeSnapshot){
                if (imgeSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final ItemDocs = imgeSnapshot.data!.docs;
                return ListView.builder(
                    itemCount: imgeSnapshot.data!.docs.length ,
                    itemBuilder: (ctx, index){
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 20,
                          child: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * 0.25,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        ItemDocs[index]['image']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(ItemDocs[index].id, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)
                                      )
                                  ),

                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: IconButton(
                                      onPressed: () {
                                        DocumentReference<Map<String, dynamic>>
                                        documentRef = FirebaseFirestore.instance.collection('carouse').doc(ItemDocs[index].id);
                                        documentRef.delete();
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      );
                    }
                );
              }
          );
        }, future: null,
      ),
    );
  }
}
