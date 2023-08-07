import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../scores/Score.dart';

class InfoUser extends StatefulWidget {
  InfoUser({
    required this.nameUser,
    required this.emailUser,
    required this.passworUser,
    required this.phonUser,
    required this.scoreUser,
    required this.douc,
    required this.index,
    required this.agent
});
  String nameUser;
  String agent ;
  String phonUser;
  String emailUser;
  String passworUser;
  int scoreUser;
  String douc;
  int index;

  @override
  State<InfoUser> createState() => _InfoUserState();
}

class _InfoUserState extends State<InfoUser> {
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
                void Score() {
                  showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) {
                    return Scores(score: userDocs[widget.index]['score'], userdc: widget.douc,);

                  });
                }
                return Scaffold(
                  appBar: AppBar(
                    title: Text(widget.nameUser, style: TextStyle( fontFamily: 'Cairo'),),
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
                  body: Container(
                    child: Column(
                      children: [
                        widgetuser(ico: Icons.person,catogray: 'name',titel: widget.nameUser,),
                        widgetuser(ico: Icons.star,catogray: 'Agent name',titel: widget.agent,),
                        widgetuser(ico: Icons.phone, catogray: 'phone', titel: widget.phonUser,),
                        widgetuser(ico: Icons.lock, catogray: 'Password', titel: widget.passworUser,),
                        widgetuser(ico: Icons.monetization_on, catogray: 'score', titel: userDocs[widget.index]['score'] ,),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.05,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          child: ElevatedButton(
                              onPressed: Score,
                              child: Text('ارسال النقاط', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
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
class widgetuser extends StatelessWidget {
  widgetuser({
    required this.ico,
    required this.catogray,
    required this.titel

  });
  IconData ico ;
  String catogray ;
  var titel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(

        children: [
          Icon(ico, color: Color(0xFF9C0000),),
          SizedBox(width: MediaQuery.of(context).size.width*0.04,),
          Text("$titel" , style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Cairo'),),

        ],
      ),
    );
  }
}

