import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class farmerFinal extends StatefulWidget {
  farmerFinal(
  {this.f_city,this.t_price,this.distance,this.path,this.d_city}
      );
  @override

  int t_price;
  int distance;
  dynamic path;
  String d_city;
  String f_city;
  _farmerFinalState createState() => _farmerFinalState(f_city,t_price,distance,path,d_city);
}


class _farmerFinalState extends State<farmerFinal> {
  _farmerFinalState(this.f_city,this.t_price,this.distance,this.path,this.d_city);

  int t_price;
  int distance;
  dynamic path;
  String d_city;
  String f_city;


  String n;
  String p;
  String a;
  String t_name;
  int t_pno;
  String t_tn;
  String t_address;
  String t_email;


  final _auth = FirebaseAuth.instance;
  final _firestore= FirebaseFirestore.instance;
  //getting the value of the variable x
  //
  // void getVariableValue() async {
  //   print("variable value is called");
  // final vx = await _firestore.collection('variable').get();
  // for(var i in vx.docs){
  //   setState((){
  //     x= i.data()['x'];
  //     print(x);
  //   });
  //
  // }
  // }

  //getting the truckdriver details using the value of the varibale x
  void getDriverDetails() async{

    print(f_city);
    final driver= await _firestore.collection('driver').where('address',isEqualTo:d_city).get();
    // print(n_driver);
    for( var i in driver.docs){
      setState(() {
        t_name= i.data()['name'];
        t_pno= i.data()['pno'];
        t_tn= i.data()['tno'];
        t_address=i.data()['address'];
        t_email=i.data()['email'];
      });
    }

  }

  // void getPrice() async{
  //   print("get price is called");
  //   final Tprice =await _firestore.collection('farmerPrice').where('email',isEqualTo: _auth.currentUser.email).get();
  //
  //   for(var tp in Tprice.docs){
  //     t_price = tp.data()['cropTprice'];
  //   }
  // }
  void getUserData() async{
    print("user data is called");
    final info= await _firestore.collection('farmer').where('email', isEqualTo: _auth.currentUser.email).get();
    for(var x in info.docs){
      setState(() {
        n=x.data()["name"];
        p=x.data()["pno"];
        a=x.data()["address"];
      });
    }
  }

  void set_prevBoookings() {
    print(t_name);
    _firestore.collection('prevBookings').add({
      'f_name':n,
      'f_email':_auth.currentUser.email,
      'f_pno':p,
      'f_address':a,
      't_price': t_price,
      'f_city' : f_city,
      't_name' : t_name,
      't_pno' : t_pno,
      't_email' : t_email,
      'distance' : distance,
      't_path' : path,
      't_email': t_email,
      't_no' : t_tn,
      'v':0
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    getDriverDetails();

  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("FARMER's APP")),
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
        height: 900,
        width: 600,
        decoration: BoxDecoration(
            image:DecorationImage(
              image: AssetImage('images/truck1.jpeg'),
              fit: BoxFit.cover,
//                    repeat: ImageRepeat.repeatY,
            )
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                      shadowColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Truck Driver Details: ",style: TextStyle(
                              fontSize: 30,
                            ),),
                            SizedBox(height: 20,),
                            Text("${t_name}",style: TextStyle(
                              fontSize: 20,
                            ),),
                            Text("${t_pno}",style: TextStyle(
                              fontSize: 20,
                            ),),
                            Text("${t_address}",style: TextStyle(
                              fontSize: 20,
                            ),),
                            Text("${t_tn}",style: TextStyle(
                              fontSize: 20,
                            ),),
                            Text("Pick-up Location: ${f_city}",style: TextStyle(
                              fontSize: 20,
                            ),),

                            SizedBox(
                              height: 30,
                            ),
                            Text("AMOUNT TO RECIEVE : Rs. $t_price",style: TextStyle(
                              fontSize: 20,
                            ),),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Path Followed by the Truck Driver :",style: TextStyle(
                              fontSize: 20,
                            ),),
                            SizedBox(
                              height: 10,
                            ),
                            Text("$path",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Total Distance : $distance KM",style: TextStyle(
                              fontSize: 20,
                            ),),

                            FlatButton(
                              color: Colors.lightBlue,
                              child: Text("CONFIRM",style: TextStyle(
                                color: Colors.white,
                              ),),
                              onPressed: (){
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('BOOKING CONFIRMED!!'),
                                      content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text('CONFIRM and GO BACK TO MAIN SCREEN',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),),
                                            ],
                                          )
                                      ),
                                      actions: <Widget>[
                                        RaisedButton(
                                          color: Colors.lightBlue,
                                          child: Text(
                                            'CONFIRM', style: TextStyle(
                                            color: Colors.white,
                                          ),),
                                          onPressed:(){
                                            set_prevBoookings();
                                            Navigator.popAndPushNamed(context, 'farmer');
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );



                              },
                            ),
                          ],
                        ),
                      )
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
