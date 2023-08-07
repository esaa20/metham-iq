import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowItems extends StatefulWidget {
  ShowItems({
    required this.kindItem,
  });

  final String kindItem;

  @override
  State<ShowItems> createState() => _ShowItemsState();
}

class _ShowItemsState extends State<ShowItems> {
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
              .collection('items')
              .doc(widget.kindItem)
              .collection(widget.kindItem)
              .snapshots(),
          builder: (ctx, ItemSnapshot) {
            if (ItemSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final ItemDocs = ItemSnapshot.data!.docs;
            return ItemSnapshot.data!.docs.length > 0
                ? ListView.builder(
              itemCount: ItemSnapshot.data!.docs.length,
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
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                  ItemDocs[index]['image_url']),
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
                            child: Text(
                              ItemDocs[index]['ItemName'],
                              style: TextStyle(fontFamily: 'Cairo'),
                            ),
                          ),
                        ),
                        //if (selectedCardIndex == index)
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
                                    child: Text(
                                      ItemDocs[index]['DiscItem'],
                                      style: TextStyle(
                                          fontFamily: 'Cairo'),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: IconButton(
                                  onPressed: () {
                                    DocumentReference<Map<String, dynamic>>
                                    documentRef = FirebaseFirestore.instance.collection('items').doc(widget.kindItem).collection(widget.kindItem).doc(ItemDocs[index]['ItemName']);
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
