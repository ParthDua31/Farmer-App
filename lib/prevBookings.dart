import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<Card> f_book=[];
final _auth = FirebaseAuth.instance;
final _firestore= FirebaseFirestore.instance;

class prevBookings extends StatefulWidget {


  @override
  _prevBookingsState createState() => _prevBookingsState();
}

class _prevBookingsState extends State<prevBookings> {

  String f_email;
  String f_add;
  String t_email;
  int t_price;
  int t_pno;
  String f_pno;
  String t_name;
  String f_name;
  String t_no;
  dynamic t_path;
  int distance;
  int v;

  @override
  void initState() {
    f_book.clear();
    getBookings();
  }

  void getBookings() async{
    final info= await _firestore.collection('prevBookings').where('f_email', isEqualTo: _auth.currentUser.email).get();
    for(var x in info.docs){
      setState(() {
        t_email=x.data()["t_email"];
        f_email= x.data()["f_email"];
        t_pno=x.data()["t_pno"];
        f_pno=x.data()["f_pno"];
        f_add=x.data()["f_address"];
        t_price=x.data()["t_price"];
        t_path=x.data()["t_path"];
        t_name=x.data()["t_name"];
        f_name=x.data()["f_name"];
        t_no=x.data()["t_no"];
        distance=x.data()["distance"];
        v=x.data()["v"];

        f_book.add(Card(
          // color: Colors.white.withAlpha(150),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListBody(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.end,
                children: [Text("Status: ",style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue,
                ),), v==1 ? Icon(Icons.verified,color: Colors.green,) : Icon(Icons.error,color: Colors.red)  ],),
                SizedBox(height: 10,),
                Text("Farmer Details: ",style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue,
                ),),
                SizedBox(height: 10,),
                Text("$f_name",style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),),
                Text("$f_add",style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),),
                Text("$f_pno",style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),),
                Text("Amount to Recieve: $t_price",style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),),
                SizedBox(height: 10,),
                Text("Truck Driver Details:",style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue,
                ),),
                SizedBox(height: 15,),
                Text("Truck Number: $t_name",style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),),
                Text("$t_name",style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),),
                Text("$t_email",style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),),
                Text("$t_pno",style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),),
                Text("Total Distance : $distance",style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),),
                Text("Path To Follow: $t_path",style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),),
              ],
            ),
          ),
        ));
      });
    }

  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Previous Bookings"),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image:DecorationImage(
                image: AssetImage('images/farmer1.jpeg'),
                fit: BoxFit.cover,
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              // shrinkWrap: true,
              itemCount: f_book.length,
              itemBuilder: (context,i){
                if(f_book[i] != null){
                  return (
                      f_book[i]
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
