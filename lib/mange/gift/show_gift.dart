import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowGift extends StatefulWidget {
  ShowGift({
    required this.kindItem,
  });

  final String kindItem;

  @override
  State<ShowGift> createState() => _ShowGiftState();
}

class _ShowGiftState extends State<ShowGift> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('gift')
              .doc(widget.kindItem)
              .collection(widget.kindItem)
              .snapshots(),
          builder: (ctx, GiftSnapshot) {
            if (GiftSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final GiftDocs = GiftSnapshot.data!.docs;

            return GiftSnapshot.data!.docs.length > 0
                ? ListView.builder(
              itemCount: GiftSnapshot.data!.docs.length,
              itemBuilder: (ctx, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 20,
                  child: SizedBox(
                   // height:  MediaQuery.of(context).size.height * 0.45,
                    child: Column(
                      children: [
                        Container(
                          height:
                          MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                  GiftDocs[index]['image_url']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8,
                            top: 8,
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              children: [
                                Text(
                                  GiftDocs[index]['giftName'],
                                  style: TextStyle(fontFamily: 'Cairo'),
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width*0.6,),
                                Text(
                                  GiftDocs[index]['giftScore'],
                                  style: TextStyle(fontFamily: 'Cairo'),
                                ),
                              ],
                            ),
                          ),
                        ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 8,
                                  top: 4,
                                  left: 8,
                                  bottom: 4,
                                ),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    // child: Text(
                                    //   GiftDocs[index]['discGift'],
                                    //   style: TextStyle(
                                    //       fontFamily: 'Cairo'),
                                    // ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: IconButton(
                                  onPressed: () {
                                    DocumentReference<Map<String, dynamic>>
                                    documentRef =
                                    FirebaseFirestore.instance
                                        .collection('gift')
                                        .doc(widget.kindItem)
                                        .collection(
                                        widget.kindItem)
                                        .doc(GiftDocs[index]['giftName']);
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
                ),
              ),
            )
                : Container();
          },
        );
      }, future: null,
    );
  }
}
