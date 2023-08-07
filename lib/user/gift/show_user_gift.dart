import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:metham/user/screens/home_screen.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ShowUserGift extends StatefulWidget {
  ShowUserGift({
    required this.kindGift,
    required this.agent,
    required this.userScore,
    required this.docid,
    required this.name,
  });
  String kindGift;
  String agent;
  int userScore;
  String docid;
  String name;

  @override
  State<ShowUserGift> createState() => _ShowUserGiftState();
}

class _ShowUserGiftState extends State<ShowUserGift> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (ctx,futureSnapshot){
          if(futureSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('gift').doc(widget.kindGift).collection(widget.kindGift).snapshots(),
              builder: (ctx, GiftSnapshot){
                if (GiftSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final GiftDocs = GiftSnapshot.data!.docs;

                void haveGift(int index){
                  //update
                  int updateScore = (widget.userScore-int.parse(GiftDocs[index]['giftScore']));
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.docid)
                        .update({
                      'score': updateScore ,
                      // Update more fields as needed
                    })
                        .then((value) => print('Data updated successfully.'))
                        .catchError((error) => print('Failed to update data: $error'));
                    //end
                 // add user to usergift
                    FirebaseFirestore.instance
                        .collection('usergift')
                        .add({
                      'giftName': GiftDocs[index]['giftName'],
                      'nameUser': widget.name,
                      'Time': FieldValue.serverTimestamp(),
                      // Add more fields as needed
                    })
                        .then((value) => print('Data added successfully.'))
                        .catchError((error) => print('Failed to add data: $error'));
                  // end
                 // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {showDialog();});
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HomeScreenUser(),));
                }

                dynamic showDialog(int index , String nameGift){
                  QuickAlert.show(
                    onConfirmBtnTap: (){
                      haveGift(index);
                      // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HomeScreenUser(),));
                    },
                    context: context,
                    type: QuickAlertType.success,
                    text: 'هل تريد الحصول على هذه الهدية !',
                    title: nameGift,
                    confirmBtnColor: Color(0xFF9C0000),
                    confirmBtnText: 'تأكيد'

                  );
                }


                return GiftSnapshot.data!.docs.length > 0 ?
                ListView.builder(
                  itemCount: GiftSnapshot.data!.docs.length,
                  itemBuilder: (ctx, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: InkWell(
                      onTap:widget.userScore>=int.parse(GiftDocs[index]['giftScore'])? () {
                        setState(() {
                          if(widget.userScore>=int.parse(GiftDocs[index]['giftScore'])){
                            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {showDialog(index,GiftDocs[index]['giftName']);});
                          //  haveGift(index);
                          }
                        });
                      }:(){
                       // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {showDialog();});
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 20,
                        child: SizedBox(
                         // height: MediaQuery.of(context).size.height * 0.42,
                          child: Column(
                            children: [
                              Container(
                                height:
                                MediaQuery.of(context).size.height * 0.3,
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
                                        style:widget.userScore<int.parse(GiftDocs[index]['giftScore'])?
                                        TextStyle(fontFamily: 'Cairo' , decoration: TextDecoration.lineThrough):
                                        TextStyle(fontFamily: 'Cairo')
                                        ,
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

                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ):
                Container();
              }
          );
        }, future: null,
    );
  }
}
