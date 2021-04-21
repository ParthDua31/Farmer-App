import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class driver extends StatefulWidget {
  @override
  _driverState createState() => _driverState();
}

class _driverState extends State<driver> {
  String n;
  String p;
  String a;
  String tn;
  final _auth= FirebaseAuth.instance;
  final _firestore= FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }
  void getUserData() async{
    final info= await _firestore.collection('driver').where('email', isEqualTo: _auth.currentUser.email).get();
    for(var x in info.docs){
      setState(() {
        n=x.data()["name"];
        p=x.data()["pno"];
        a=x.data()["address"];
        tn=x.data()["truckNo"];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.local_shipping),text: 'TRUCK DRIVER'),
              Tab(icon: Icon(Icons.assignment),text: 'GUIDELINES',),
            ],
          ),
          title: Center(child: Text("TRUCK DRIVER's APP")),
          backgroundColor: Colors.blue,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                ),
                child: Text(
                  '$n',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),

              ListTile(
                leading: Icon(Icons.email),
                title: Text('EMAIL'),
                subtitle: Text('${_auth.currentUser.email}'),
              ),
              ListTile(
                leading: Icon(Icons.assignment_ind),
                title: Text('ADDRESS'),
                subtitle: Text('$a'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('PHONE NUMBER'),
                subtitle: Text('$p'),
              ),
              ListTile(
                leading: Icon(Icons.local_shipping),
                title: Text('TRUCK NUMBER'),
                subtitle: Text('$tn'),
              ),
              ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: (){
                    Navigator.pushNamed(context, 'setting');
                  }
              ),
              ListTile(
                leading: Icon(Icons.power_settings_new),

                title: Text('Logout'),
                onTap: () async {
                  _auth.signOut();
                  Navigator.popUntil(context, ModalRoute.withName('login'));
                },
              ),

            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              image:DecorationImage(

                image: AssetImage('images/truck1.jpeg'),
                fit: BoxFit.cover,
              )
          ),
          child: TabBarView(
              children:[ SafeArea(
                  child:Center(
                    child: SingleChildScrollView(
                      child: Container(
                        height:500,
                        width:380,
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Text("TRUCK NUMBER : $tn",style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,

                              ),),
                              SizedBox(
                                height: 30,
                              ),
                              FlatButton(
                                color: Colors.lightBlue,
                                child: Text("CHECK BOOKING",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white,

                                ),),
                                // onPressed: (){
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(builder: (context) => truckPage(n:n,p:p,a:a,tn:tn)
                                //     ),
                                //   );
                                // },
                              ),

                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
              ),
                Column(
                  children: <Widget>[
                    Card(

                        child: ListTile(
//                        leading: Image.asset('images/Tissue.png'),
                          title: Text('*PRE AND POST TRIP INSPECTIONS OF EQUIPMENT/VEHICLES MUST BE COMPLETED DAILY',style: TextStyle(
                            color: Colors.blue,
                          ),),
                        )
                    ),
                    Card(

                        child: ListTile(
//                        leading: Image.asset('images/Wash-Hands.png'),

                          title: Text('*COVID SAFETY MEASURES AND PRECAUTIONS MUST BE FOLLOWED WHILE LOADING AND UNLOADING THE GOODS',style: TextStyle(
                            color: Colors.blue,
                          ),),
                        )
                    ),
                    Card(
                        child: ListTile(
//                        leading:Image.asset('images/Disinfectant.png'),

                          title: Text('*CLEAR VEHICLE OF DEBRIS AFTER BEING LOADED AND AFTER UNLOADING',style: TextStyle(
                            color: Colors.blue,
                          ),),

                        )
                    ),
                    Card(

                        child: ListTile(
//                        leading : Image.asset('images/Social-Distancing.png'),
                          title: Text('*ALL MUST WEAR ADEQUATE AND PROPER FITTING FOOTWEAR ',style: TextStyle(
                            color: Colors.blue,
                          ),),

                        )
                    ),
                    Card(

                        child: ListTile(
//                        leading: Image.asset('images/Pandemic-Flu.png'),

                          title:Text('*SMOKING IS NOT ALLOWED DURING FUELING OPERATIONS',style: TextStyle(
                            color: Colors.blue,
                          ),),

                        )
                    ),
                    Card(

                        child: ListTile(
//                        leading: Image.asset('images/Pandemic-Flu.png'),

                          title:Text('*ALL ACCIDENTS MUST BE REPORTED TO THE SUPERVISOR IMMEDIATELY ',style: TextStyle(
                            color: Colors.blue,
                          ),),

                        )
                    ),


                  ],
                )
              ]

          ),
        ),
      ),
    );
  }
}
