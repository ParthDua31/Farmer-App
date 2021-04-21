import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class driver extends StatefulWidget {
  @override
  _driverState createState() => _driverState();
}
List<Card> f_book=[];
class _driverState extends State<driver> {
  String n;
  int p;
  String a;
  String tn;
  final _auth= FirebaseAuth.instance;
  final _firestore= FirebaseFirestore.instance;

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
    // TODO: implement initState
    super.initState();
    f_book.clear();
    getUserData();
    getBookings();
  }

  // void updateV(){
  //    _firestore.collection('prevBookings').doc("").update({'v': v==1 ? 0:1});
  // }



  void getUserData() async{
    final info= await _firestore.collection('driver').where('email', isEqualTo: _auth.currentUser.email).get();
    for(var x in info.docs){
      setState(() {
        n=x.data()["name"];
        p=x.data()["pno"];
        a=x.data()["address"];
        tn=x.data()["tno"];
      });
    }
  }


  void getBookings() async{
    final info= await _firestore.collection('prevBookings').where('t_email', isEqualTo: _auth.currentUser.email).get();
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
                Text("Truck Number: $t_no",style: TextStyle(
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
                SizedBox(height: 10,),

                // Row(crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [Text("Status: ",style: TextStyle(
                //     fontSize: 25,
                //     color: Colors.blue,
                //   ),), v==1 ? Icon(Icons.verified,color: Colors.green,) : Icon(Icons.error,color: Colors.red)  ],),
              // Center(child: FlatButton(
              //   disabledColor: Colors.grey,
              //   child: Text("COMPLETED",style: TextStyle(
              //   fontSize: 18,
              //   ),),
              // onPressed: v==1?  (){
              //     // updateV();
              //     f_book.clear();
              //     getBookings();
              // } : (){},
              // ),
              // )
              ],
            ),
          ),
        ));
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
              Tab(icon: Icon(Icons.local_shipping),text: 'BOOKINGS'),
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
                child: Container(
                  // decoration: BoxDecoration(
                  //     image:DecorationImage(
                  //       image: AssetImage('images/truck1.jpeg'),
                  //       fit: BoxFit.cover,
                  //     )
                  // ),
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
