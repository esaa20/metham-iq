import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../methods/drawer.dart';
import '../show_items/catogriy.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (ctx,futureSnapshot){
      if(futureSnapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      }
      return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (ctx,Snapshot){
            if (Snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Scaffold(
              appBar: AppBar(
                title: Text('المدير',style: TextStyle(fontFamily: 'Cairo',),),
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
              drawer: drawerHead(
              ),
              body: catogriy(),

            );
          });
    }, future: null,);
  }
}
