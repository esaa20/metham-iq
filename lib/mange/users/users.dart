import 'package:flutter/material.dart';
import 'package:metham/mange/users/serch_user.dart';
import 'package:metham/mange/users/user_show.dart';


class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  int slected = 1 ;
  final pages = [
    Container(child: UserShow(agent: '1',),),
    Container(child: UserShow(agent: '0',),),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('مستخدمين', style: TextStyle(fontFamily: 'Cairo'),),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF9C0000), Color(0xFF2E0101)],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> Search())) ;
          }, icon: Icon(Icons.search))
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(    topLeft: Radius.circular(20), topRight: Radius.circular(20),),
        child: NavigationBar(
            indicatorColor:Colors.grey[50],
          backgroundColor: Color(0xFF9C0000),
          height: MediaQuery.of(context).size.height*0.08,
          selectedIndex: slected,
          onDestinationSelected: (sle) => setState(() {
            this.slected = sle ;
          }),
          destinations: [
            NavigationDestination(icon: Icon(Icons.person), label: 'Agent',),
            NavigationDestination(icon: Icon(Icons.people), label: 'All users',),
          ],
        ),
      ),
      body: pages[slected]
    );
  }
}
