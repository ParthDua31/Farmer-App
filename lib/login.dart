import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class login extends StatefulWidget {
  static String id = "login";
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final _auth = FirebaseAuth.instance;
  final _firestore= FirebaseFirestore.instance;
  String email;
  String pass;
  bool showSpinner=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("FARMER'S APP")),
        backgroundColor: Colors.black54,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Container(
            height: 800,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image:AssetImage("images/farmer1.jpeg"),
                  fit: BoxFit.cover
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),

                  Row(
                      children:[
                        // Hero(
                        //   tag: 'logo',
                        //   child: Icon(
                        //     Icons.add,
                        //     color: Colors.red[900],
                        //     size: 150,
                        //
                        //   ),
                        // ),
                        Container(
                          height:80,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              // Text(
                              //   "Be",
                              //   style: TextStyle(fontSize: 40.0,
                              //     color: Colors.indigo,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                              // SizedBox(width: 20,),
                              Container(
                                width: 190,
                                child: RotateAnimatedTextKit(
                                  text: ["SOW", "SELL", "EARN"],
                                  textStyle: TextStyle(fontSize: 35.0, fontFamily: "Horizon", color: Colors.indigo, fontWeight: FontWeight.bold,),
                                  textAlign: TextAlign.start,
                                  // isRepeatingAnimation: true,
                                  repeatForever: true,

                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color: Colors.grey.withAlpha(150),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListBody(
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5,),
                            TextField(
                              onChanged: (value) {
                                email = value;
                              },
                              decoration: InputDecoration(
                                  icon: Icon(
                                      Icons.email,
                                      color:Colors.white
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.6),

                                  focusColor: Colors.lightBlue[100],
                                  labelText: 'Enter your Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color:Colors.white,
                              ),
                            ),
                            SizedBox(height: 5,),
                            TextField(

                              onChanged: (value) {
                                pass = value;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  icon: Icon(
                                      Icons.account_circle_rounded,
                                      color:Colors.white
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.6),

                                  focusColor: Colors.lightBlue[100],
                                  labelText: 'Enter your Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            FlatButton(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                setState(() {
                                  showSpinner=true;
                                });
                                try {
                                  final user = await _auth.signInWithEmailAndPassword(
                                      email: email, password: pass);
                                  // displayName=email;
                                  if (user != null) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('LOGIN SUCCESSFUL!!'),
                                          content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text(
                                                    'PROCEED',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          actions: <Widget>[
                                            RaisedButton(
                                                color: Colors.lightBlue,
                                                child: Text(
                                                  'PROCEED',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                            onPressed: () async{
                                              final info= await _firestore.collection('farmer').where('email', isEqualTo: _auth.currentUser.email).get();
                                              if(info.docs.isNotEmpty){
                                                Navigator.pushNamed(context, 'farmer');
                                              }
                                              else{
                                                Navigator.pushNamed(context, 'driver');
                                              }
                                              setState(() {
                                                showSpinner=true;
                                              });
                                            }
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          // backgroundColor: Colors.grey.withAlpha(200),
                                          title: Text('LOGIN UNSUCCESSFUL!!'),
                                          content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text(
                                                    'ENTER CORRECT USERNAME OR PASSWORD',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          actions: <Widget>[
                                            RaisedButton(
                                              child: Text('BACK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                              color: Colors.blueAccent.withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.white)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


//
//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class login extends StatefulWidget {
//   @override
//   _loginState createState() => _loginState();
// }
//
// class _loginState extends State<login> {
//   final _auth = FirebaseAuth.instance;
//   String email;
//   String pass;
//   final _firestore= FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text("FARMER's APP")),
//         backgroundColor: Colors.blue,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 200,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ListBody(
//                         children: [
//                           Text(
//                             'Email',
//                             style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.lightBlue,
//                             ),
//                           ),
//                           TextField(
//                             onChanged: (value) {
//                               email = value;
//                             },
//                             decoration: InputDecoration(
//                                 icon: Icon(
//                                   Icons.email,
//                                 ),
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 focusColor: Colors.lightBlue[100],
//                                 labelText: 'Enter your Email',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                                 )),
//                           ),
//                           SizedBox(
//                             height: 30,
//                           ),
//                           Text(
//                             'Password',
//                             style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.lightBlue,
//                             ),
//                           ),
//                           TextField(
//                             onChanged: (value) {
//                               pass = value;
//                             },
//                             obscureText: true,
//                             decoration: InputDecoration(
//                                 icon: Icon(
//                                   Icons.account_circle_rounded,
//                                 ),
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 focusColor: Colors.lightBlue[100],
//                                 labelText: 'Enter your Password',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                                 )),
//                           ),
//                           SizedBox(
//                             height: 30,
//                           ),
//                           FlatButton(
//                             child: Text(
//                               'Login',
//                               style: TextStyle(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             onPressed: () async {
//                               try {
//                                 final user = await _auth.signInWithEmailAndPassword(
//                                     email: email, password: pass);
//                                 // displayName=email;
//                                 if (user != null) {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return AlertDialog(
//                                         title: Text('LOGIN SUCCESSFUL!!'),
//                                         content: SingleChildScrollView(
//                                             child: ListBody(
//                                           children: <Widget>[
//                                             Text(
//                                               'PROCEED',
//                                               style: TextStyle(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ],
//                                         )),
//                                         actions: <Widget>[
//                                           RaisedButton(
//                                             color: Colors.lightBlue,
//                                             child: Text(
//                                               'PROCEED',
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                             onPressed: () async{
//                                               final info= await _firestore.collection('farmer').where('email', isEqualTo: _auth.currentUser.email).get();
//                                               if(info.docs.isNotEmpty){
//                                               Navigator.pushNamed(context, 'farmer');
//                                               }
//                                               else{
//                                                 Navigator.pushNamed(context, 'driver');
//                                               }
//                                             },
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 } else {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return AlertDialog(
//                                         title: Text('LOGIN UNSUCCESSFUL!!'),
//                                         content: SingleChildScrollView(
//                                             child: ListBody(
//                                           children: <Widget>[
//                                             Text(
//                                               'ENTER CORRECT USERNAME OR PASSWORD',
//                                               style: TextStyle(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ],
//                                         )),
//                                         actions: <Widget>[
//                                           RaisedButton(
//                                             child: Text('BACK'),
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 }
//                               } catch (e) {
//                                 print(e);
//                               }
//                             },
//                             color: Colors.blueAccent,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(18.0),
//                               // side: BorderSide(color: Colors.red)
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
