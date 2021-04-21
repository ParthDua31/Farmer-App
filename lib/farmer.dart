import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/pricePage.dart';

class farmer extends StatefulWidget {
  @override
  _farmerState createState() => _farmerState();
}
class _farmerState extends State<farmer> {
  List<Card> c_list=[];
  String n;
  String p;
  String a;
  int s_value=1;
  int crop_p=0;
  int crop_v=1;
  final _auth = FirebaseAuth.instance;
  final _firestore= FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
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
  void getPrice(s_value) async{
    final price= await _firestore.collection('cropPrice').where('cno',isEqualTo: s_value).get();
    for(var pr in price.docs){
      setState(() {
        crop_p = pr.data()['price'];
        print(crop_p);
      });
    }
  }
  void getBookings() async{
    final bookings= await _firestore.collection('farmerPrice').where('email', isEqualTo: _auth.currentUser.email).get();
    for(var v in bookings.docs){
        c_list.add(Card(
          child: ListBody(
            children: [

            ],
          ),
        ));
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
              Tab(icon: Icon(Icons.nature_people),text: 'FARMER'),
              Tab(icon: Icon(Icons.assignment),text: 'GUIDELINES',),
            ],
          ),
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
          decoration: BoxDecoration(
              image:DecorationImage(
                image: AssetImage('images/farmer1.jpeg'),
                fit: BoxFit.cover,
              )
          ),
          child: TabBarView(
              children:[ SingleChildScrollView(
                child: SafeArea(
                    child:Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.grey.withAlpha(150),
                              child: ListBody(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Card(
                                      color: Colors.white.withAlpha(250),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListBody(
                                          children: [
                                            Text("Welcome !!",style: TextStyle(
                                              fontSize: 50,
                                              color: Colors.blue,
                                            ),),
                                            Text("$n",style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.blue,
                                            ),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                 Padding(
                                   padding: const EdgeInsets.all(15.0),
                                   child: Card(
                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: ListBody(
                                         children: [
                                           Text("Select Your Crop",style: TextStyle(
                                               fontSize: 30,
                                               fontWeight: FontWeight.bold,
                                               color: Colors.blue
                                           ),),
                                           DropdownButton(
                                             dropdownColor: Colors.white,
                                             iconSize: 50,
                                             iconDisabledColor: Colors.red,
                                             iconEnabledColor: Colors.blue,
                                             value: s_value,
                                             items: [
                                               DropdownMenuItem(
                                                 child: Text("PADDY(COMMON)",style: TextStyle(
                                                   fontSize: 20,
                                                   color: Colors.blue,
                                                 ),),
                                                 value: 1,
                                               ),
                                               DropdownMenuItem(
                                                 child: Text("PADDY(GRADE A)",style: TextStyle(
                                                   fontSize: 20,
                                                   color: Colors.blue,
                                                 )),
                                                 value: 2,
                                               ),
                                               DropdownMenuItem(
                                                 child: Text("WHEAT",style: TextStyle(
                                                   fontSize: 20,
                                                   color: Colors.blue,
                                                 )),
                                                 value: 3,
                                               ),
                                               DropdownMenuItem(
                                                 child: Text("JOWAR(MALDANDI)",style: TextStyle(
                                                   fontSize: 20,
                                                   color: Colors.blue,
                                                 )),
                                                 value: 4,
                                               ),
                                               DropdownMenuItem(
                                                 child: Text("JOWAR(HYBRID)",style: TextStyle(
                                                   fontSize: 20,
                                                   color: Colors.blue,
                                                 )),
                                                 value: 5,
                                               ),
                                               DropdownMenuItem(
                                                 child: Text("BAJRA",style: TextStyle(
                                                   fontSize: 20,
                                                   color: Colors.blue,
                                                 )),
                                                 value: 6,
                                               ),
                                               DropdownMenuItem(
                                                 child: Text("RAGI",style: TextStyle(
                                                   fontSize: 20,
                                                   color: Colors.blue,
                                                 )),
                                                 value: 7,
                                               ),
                                               DropdownMenuItem(
                                                 child: Text("MAIZE",style: TextStyle(
                                                   fontSize: 20,
                                                   color: Colors.blue,
                                                 )),
                                                 value: 8,
                                               ),
                                               DropdownMenuItem(
                                                 child: Text("BARLEY",style: TextStyle(
                                                   fontSize: 20,
                                                   color: Colors.blue,
                                                 )),
                                                 value: 9,
                                               ),
                                               DropdownMenuItem(
                                                 child: Text("TOMATO",style: TextStyle(
                                                   fontSize: 20,
                                                   color: Colors.blue,
                                                 )),
                                                 value: 10,
                                               ),
                                               DropdownMenuItem(
                                                 child: Text("POTATO",style: TextStyle(
                                                   fontSize: 20,
                                                   color: Colors.blue,
                                                 )),
                                                 value: 11,
                                               ),
                                               DropdownMenuItem(
                                                 child: Text("ONION",style: TextStyle(
                                                   fontSize: 20,
                                                   color: Colors.blue,
                                                 )),
                                                 value: 12,
                                               ),
                                               DropdownMenuItem(
                                                 child: Text("CAULIFLOWER",style: TextStyle(
                                                   fontSize: 20,
                                                   color: Colors.blue,
                                                 )),
                                                 value: 13,
                                               ),
                                             ],
                                             onChanged:(value) {
                                               s_value=value;
                                               getPrice(s_value);
                                             },
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                 ),

                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListBody(
                                          children: [
                                            Text("Select Quantity",style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),),
                                            Text("(in Quintal)",style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(18.0),
                                                      side: BorderSide(color: Colors.white)
                                                  ),
                                                  color: Colors.lightBlue,
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: (){
                                                    setState(() {
                                                      if(crop_v>1){
                                                        crop_v--;
                                                      }
                                                      else{
                                                      }
                                                    });
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 20,

                                                ),
                                                Text("$crop_v",style: TextStyle(
                                                    fontSize: 50,
                                                    color: Colors.blue
                                                ),),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(50.0),
                                                      side: BorderSide(color: Colors.white)
                                                  ),
                                                  color: Colors.lightBlue,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,

                                                  ),
                                                  onPressed: (){
                                                    setState(() {
                                                      if(crop_v < 101){
                                                        crop_v++;
                                                      }
                                                      else{
                                                      }
                                                    }
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            Center(
                                              child: Text("(ENTER VALUE B/W 1 AND 100)",style: TextStyle(
                                                  color: Colors.blue
                                              ),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                Row(
                                  children: [
                                    SizedBox(width: 40,),
                                    FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.white)
                                      ),
                                      color: Colors.lightBlue,
                                      child: Text("PROCEED",style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),),
                                      onPressed: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => pricePage(t_price: crop_p * crop_v )));
                                      },
                                    ),
                                    SizedBox(width: 20,),
                                    FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.white)
                                      ),
                                      color: Colors.lightBlue,
                                      child: Text("PREVIOUS BOOKINGS",style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),),
                                      onPressed: () async{
                                        // getBookings();
                                     Navigator.pushNamed(context, 'prevBookings');
                                      },
                                    )
                                  ],
                                ),


                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ),
                Column(
                  children: <Widget>[
                    Card(

                        child: ListTile(
//                        leading: Image.asset('images/Tissue.png'),
                          title: Text('* SELECT AN ADEQUATE SOWING DATE AVOIDING DROUGHTS,PESTS AND DISEASES',style: TextStyle(
                            color: Colors.blue,
                          ),),
                        )
                    ),
                    Card(

                        child: ListTile(
//                        leading: Image.asset('images/Wash-Hands.png'),

                          title: Text('* DEVELOP PRACTICES TO ELIMINATE PESTS AND DISEASES FROM THE SEEDS IN ORDER NOT TO AFFECT THE CROP',style: TextStyle(
                            color: Colors.blue,
                          ),),
                        )
                    ),
                    Card(
                        child: ListTile(
//                        leading:Image.asset('images/Disinfectant.png'),
                          title: Text('*INSTALL RUBBISH BINS IN STRATEGIC ZONES OF THE FIELD AND THROW THE RUBBISH IN THEM ONCE THE WORKING DAY IS OVER',style: TextStyle(
                            color: Colors.blue,
                          ),),

                        )
                    ),
                    Card(

                        child: ListTile(
//                        leading : Image.asset('images/Social-Distancing.png'),
                          title: Text('*USE THE REQUIRED AMOUNT OF WATER FOR SAVINGS AND CARE OF THE CROP',style: TextStyle(
                            color: Colors.blue,
                          ),),

                        )
                    ),
                    Card(

                        child: ListTile(
//                        leading: Image.asset('images/Pandemic-Flu.png'),

                          title:Text('*SELECT IMPROVED SEEDS AND RESISTANT TO THE MOST FREQUENT DISEASES ACCORDING TO THE RECOMMENDATIONS OF THE TECHNICIAN',style: TextStyle(
                            color: Colors.blue,
                          ),),

                        )
                    ),
                    Card(

                        child: ListTile(
//                        leading: Image.asset('images/Pandemic-Flu.png'),

                          title:Text('*DO NOT PERFORM APPLICATIONS AND AGRO-CHEMICAL PREPARATIONS NEAR THE WATER SOURCE',style: TextStyle(
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
