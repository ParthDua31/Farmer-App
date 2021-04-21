import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'login.dart';
import 'signup.dart';
class welcome extends StatefulWidget {
  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:
        Container(
          // decoration: BoxDecoration(
          //     image:DecorationImage(
          //       image: AssetImage('images/farmer1.jpeg'),
          //       fit: BoxFit.cover,
          //     )
          // ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Text('WELCOME!!',style: TextStyle(
                  color: Colors.blue,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),),
                TypewriterAnimatedTextKit(
                  text: ["To Farmer\'s App"],
                  textStyle: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold,color: Colors.lightBlue,),
                ),

                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
//                  margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListBody(
                        children: <Widget>[
                          FlatButton(
                            color: Colors.lightBlueAccent,
                            child: Text('LOGIN',style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                            ),),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              // side: BorderSide(color: Colors.red)
                            ),
                            onPressed: (){
                              Navigator.pushNamed(context, 'login');
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          FlatButton(
                            color: Colors.lightBlueAccent,
                            child: Text('SIGN-UP',style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                            ),),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              // side: BorderSide(color: Colors.red)
                            ),
                            onPressed: (){
                              Navigator.pushNamed(context, 'sign-up');
                            },
                          )
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
    );
  }
}


