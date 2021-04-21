import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/farmerFinal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'gmaps.dart';
final _firestore= FirebaseFirestore.instance;

List<DropdownMenuItem> menu =[];

String c_value;
class pricePage extends StatefulWidget {
  int t_price;
  pricePage({this.t_price});
  @override
  _pricePageState createState() => _pricePageState(t_price);
}
class _pricePageState extends State<pricePage> {
  _pricePageState(this.t_price);

  List<String> cities=['srinagar','jammu','shimla','dehradun','haridwar','roorkee','chandigarh','jalandhar','amritsar','ludhiana','karnal',
    'muzaffarnagar','meerut','delhi','alwar','bikaner','jaipur','gandhinagar','udaipur','kota','ahemdabad','mumbai','panaji','bengaluru',
    'kochi','chennai','vishakhapatnam','bhubaneshwar','bhopal','nagpur','nanded','kolkata','patna','agra','lucknow'];


  int s_value=1;
  String n;
  String p;
  String a;
  int t_price;
  final _auth=FirebaseAuth.instance;
  final _firestore=  FirebaseFirestore.instance;

  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    getList();
    // getPrice();
  }
  void getList(){
    for(int i=0;i<cities.length;i++){
      menu.add(  DropdownMenuItem(
        onTap: (){
          setState(() {
            s_value=i;
            c_value=cities[s_value];
          });
        },
        child: Text("${cities[i]}",style: TextStyle(
          fontSize: 20,
          color: Colors.blue,
        ),),
        value: i,
      ));
    }
  }

  void getUserData() async{
    final info= await _firestore.collection('farmer').where('email', isEqualTo: _auth.currentUser.email).get();
    for(var x in info.docs){
      setState(() {
        n=x.data()["name"];
        p=x.data()["pno"];
        a=x.data()["address"];
      });
    }
  }
  void getPrice() async{
    final Tprice =await _firestore.collection('farmerPrice').where('email',isEqualTo: _auth.currentUser.email).get();
    for(var tp in Tprice.docs){
      setState(() {
        t_price = tp.data()['cropTprice'];
      });
    }
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
              image: AssetImage('images/farmer1.jpeg'),
              fit: BoxFit.cover,
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
                        child:ListBody(
                          children: <Widget>[
                            Text("Price of Crop : Rs. ${t_price}",style: TextStyle(
                              fontSize: 30,
                              color: Colors.blue,
                            ),),
                            Text("Farmer Details: ",style: TextStyle(
                              fontSize: 30,
                            ),),
                            Text("$n",style: TextStyle(
                              fontSize: 20,
                            ),),
                            Text("$p",style: TextStyle(
                              fontSize: 20,
                            ),),
                            Text("$a",style: TextStyle(
                              fontSize: 20,
                            ),),
                            SizedBox(
                              height: 50,
                            ),
                            Text("Your City ",style: TextStyle(
                              fontSize: 20,
                            ),),
                            Text("(Select the pick-up location city)",style: TextStyle(
                              fontSize: 12,
                            ),),

                            DropdownButton(
                              dropdownColor: Colors.white,
                              iconSize: 50,
                              iconDisabledColor: Colors.red,
                              iconEnabledColor: Colors.blue,
                              value: s_value,
                              items: [
                                DropdownMenuItem(
                                  child: Text("Srinagar",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  ),),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("Jammu",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text("Shimla",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 3,
                                ),
                                DropdownMenuItem(
                                  child: Text("Dehradun",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 4,
                                ),
                                DropdownMenuItem(
                                  child: Text("Haridwar",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 5,
                                ),
                                DropdownMenuItem(
                                  child: Text("Roorkee",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 6,
                                ),
                                DropdownMenuItem(
                                  child: Text("Chandigarh",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 7,
                                ),
                                DropdownMenuItem(
                                  child: Text("Jalandhar",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 8,
                                ),
                                DropdownMenuItem(
                                  child: Text("Amritsar",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 9,
                                ),
                                DropdownMenuItem(
                                  child: Text("Ludhiana",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 10,
                                ),
                                DropdownMenuItem(
                                  child: Text("Karnal",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 11,
                                ),
                                DropdownMenuItem(
                                  child: Text("Muzaffarnagar",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 12,
                                ),
                                DropdownMenuItem(
                                  child: Text("Meerut",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 13,
                                ),
                                DropdownMenuItem(
                                  child: Text("Delhi",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 14,
                                ),
                                DropdownMenuItem(
                                  child: Text("Alwar",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 15,
                                ),
                                DropdownMenuItem(
                                  child: Text("Bikaner",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 16,
                                ),
                                DropdownMenuItem(
                                  child: Text("Jaipur",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 17,
                                ),
                                DropdownMenuItem(
                                  child: Text("Gandhinagar",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 18,
                                ),
                                DropdownMenuItem(
                                  child: Text("Udaipur",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 19,
                                ),
                                DropdownMenuItem(
                                  child: Text("Kota",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 20,
                                ),
                                DropdownMenuItem(
                                  child: Text("Ahemdabad",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 21,
                                ),
                                DropdownMenuItem(
                                  child: Text("Mumbai",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 22,
                                ),
                                DropdownMenuItem(
                                  child: Text("Panaji",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 23,
                                ),
                                DropdownMenuItem(
                                  child: Text("Bengaluru",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 24,
                                ),
                                DropdownMenuItem(
                                  child: Text("Kochi",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 25,
                                ),
                                DropdownMenuItem(
                                  child: Text("Chennai",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 26,
                                ),
                                DropdownMenuItem(
                                  child: Text("Vishakhapatnam",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 27,
                                ),
                                DropdownMenuItem(
                                  child: Text("Bhubaneshwar",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 28,
                                ),
                                DropdownMenuItem(
                                  child: Text("Bhopal",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 29,
                                ),
                                DropdownMenuItem(
                                  child: Text("Nagpur",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 30,
                                ),
                                DropdownMenuItem(
                                  child: Text("Nanded",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 31,
                                ),
                                DropdownMenuItem(
                                  child: Text("Kolkata",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 32,
                                ),
                                DropdownMenuItem(
                                  child: Text("Patna",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 33,
                                ),
                                DropdownMenuItem(
                                  child: Text("Agra",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 34,
                                ),
                                DropdownMenuItem(
                                  child: Text("Lucknow",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  )),
                                  value: 35,
                                ),
                              ],

                              onChanged:(value) {
                                setState(() {
                                  s_value=value;
                                  c_value=cities[s_value-1];
                                });

                              },
                            ),

                            FlatButton(
                              color: Colors.lightBlue,
                              child: Text("Book Truck",style: TextStyle(
                                color: Colors.white,
                              ),),
                              onPressed: (){
                                List<dynamic> l = getGraph(c_value);
                                //
                                int distance = l[0];
                                dynamic path= l[1];
                                String d_city= l[2];
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('CONFIRM YOUR BOOKING !!'),
                                      content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text('IF YOU WANT TO CONFIRM BOOKING THEN CLICK ON \'CONFIRM\' BUTTON',
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
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => farmerFinal(f_city: c_value, t_price: t_price,distance: distance,path:path,d_city:d_city)));
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

