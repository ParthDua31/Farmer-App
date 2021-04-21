import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// enum loginType{Farmer, TruckDriver}
// loginType _lt = loginType.Farmer;
class common extends StatefulWidget {
  @override
  _commonState createState() => _commonState();
}

class _commonState extends State<common> {
  String name;
  String pno;
  String address;
  final _auth = FirebaseAuth.instance;
  final _firestore= FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("FARMER'S APP")),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        // decoration: BoxDecoration(
        //     image:DecorationImage(
        //
        //       image: AssetImage('images/farmer1.jpeg'),
        //       fit: BoxFit.cover,
        //     )
        // ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              // height: 460,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListBody(
                          children: [
                            Text("NAME: "),
                            TextField(
                              onChanged: (value){
                                name=value;
                              },
                              decoration: InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text("PHONE NO.: "),
                            TextField(
                              onChanged:(value){
                                pno = value;
                              },
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text("ADDRESS: "),
                            TextField(
                              onChanged: (value){
                                address = value;
                              },
                              decoration: InputDecoration(
                                labelText: 'Address',
                                border: OutlineInputBorder(
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Row(
                            //   children: <Widget>[
                            //     Radio(
                            //       value: loginType.Farmer,
                            //       groupValue: _lt,
                            //       onChanged: (loginType value){
                            //         setState(() {
                            //           _lt=value;
                            //         });
                            //       },
                            //     ),
                            //     Text("Farmer"),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     Radio(
                            //       value: loginType.TruckDriver,
                            //       groupValue: _lt,
                            //       onChanged: (loginType value){
                            //         setState(() {
                            //           _lt=value;
                            //         });
                            //       },
                            //     ),
                            //     Text("Truck Driver"),
                            //   ],
                            // ),
                            SizedBox(
                              height: 15,
                            ),
                            FlatButton(
                              color: Colors.lightBlue,
                              child: Text("SUBMIT",style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),),
                              onPressed: (){
                                _firestore.collection('farmer').add({
                                  'email': _auth.currentUser.email,
                                  'address':address,
                                  'pno':pno,
                                  'name':name
                                });
                                Navigator.pushNamed(context, 'farmer');
                              },

                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
