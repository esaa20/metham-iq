import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:metham/user/show_items/itmes.dart';


class catogriy extends StatelessWidget {
  const catogriy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (ctx,futureSnapshot){
          if(futureSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('items').snapshots(),
              builder: (ctx, catogrySnapshot){
                if (catogrySnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final catoryDocs = catogrySnapshot.data!.docs;

                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      CarouseOffer(),
                      catocriy(catoryDocs: catoryDocs),
                    ],
                  ),

                );

              }
          );
        }, future: null,
    );
  }
}
class catocriy extends StatelessWidget {
  const catocriy({
  super.key,
  required this.catoryDocs,
  });

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> catoryDocs;

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    return Expanded(
      child: Container(
        child: CarouselSlider.builder(
          itemCount: catoryDocs.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => Items(
                      catogryName: catoryDocs[index].id,
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        image: DecorationImage(
                            image: NetworkImage(catoryDocs[index]['image']),
                            fit: BoxFit.cover
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black12,
                            Colors.grey,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    height: hight*0.052,
                    child: Center(
                      child: Text(
                        catoryDocs[index].id,
                        style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold , color: Colors.grey[50],
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                      color: Color(0xFF9C0000),
                    ),
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
            // Customize the carousel options as needed
            height: hight*0.5122,
            enlargeCenterPage: true,
            viewportFraction: 0.8, // Adjust the fraction to control the visible items
            // Add more options if required
          ),
        ),
      ),
    );
  }
}

class CarouseOffer extends StatelessWidget {
  const CarouseOffer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    print(hight);
    return FutureBuilder(
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('carouse').snapshots(),
          builder: (ctx, carouseSnapshot) {
            if (carouseSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final carouseDocs = carouseSnapshot.data!.docs;
            return CarouselSlider.builder(
              itemCount: carouseSnapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Container(
                  margin: EdgeInsets.only(top: hight*0.01920391084, bottom: hight*0.01),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 1,
                        blurRadius: 5,

                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(carouseDocs[index]['image']),
                      fit: BoxFit.cover,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black12,
                        Colors.grey,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
              ),
            );
          },
        );
      }, future: null,
    );
  }
}