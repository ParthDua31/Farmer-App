
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:directed_graph/directed_graph.dart';



import 'package:directed_graph/directed_graph.dart';
final _firestore= FirebaseFirestore.instance;

// String f_name;

// void get_fname() async{
//   final info = await _firestore.collection('driver').where('address', isEqualTo: f_cty).get();
//   for (var x in info.docs) {
//       f_name = x.data()["f_name"];
//   }
// }


List<dynamic> getGraph(String city) {

  String f_cty;

  int comparator(
      String s1,
      String s2,
      ) {
    return s1.compareTo(s2);
  }

  int sum(int left, int right) => left + right;

  var graph =WeightedDirectedGraph<String,int>({
    'srinagar': {'jammu' : 150,'srinagar':0 },
    'jammu':{ 'srinagar' : 150 , 'shimla':75 ,'jammu':0},
    'shimla':{'jammu':75, 'dehradun':120, 'chandigarh':180},
   'dehradun':{'srinagar':120,'roorkee':55,'haridwar':40,'dehradun':0},
    'haridwar':{'dehradun':40,'roorkee':30},
    'roorkee':{'haridwar':30,'dehradun':55,'muzaffarnagar':80},
    'chandigarh':{'shimla':180,'jalandhar':65,'karnal':60},
    'jalandhar':{'chandigarh':65,'amritsar':25,'ludhiana':30},
   'amritsar':{'jalandhar':25},
  'ludhiana':{'jalandhar':30,'karnal':60},
  'karnal':{'ludhiana':60,'chandigarh':40,'delhi':35},
    'muzaffarnagar':{'roorkee':80,'meerut':40,'delhi':100},
  'meerut':{'muzaffarnagar':40,'delhi':80},
   'delhi':{'muzaffarnagar':100,'meerut':80,'karnal':35,'lucknow':300,'alwar':175,'jaipur':120,'kota':700,'agra':100,'delhi':0},
    'alwar':{'delhi':175,'jaipur':90,'bikaner':115},
    'bikaner':{'alwar':115},
    'jaipur':{'alwar':90,'delhi':120,'gandhinagar':275,'udaipur':80,'kota':300},
    'gandhinagar':{'jaipur':275,'udaipur':150},
    'udaipur':{'gandhinagar':150,'jaipur':80,'kota':250,'ahemdabad':350,'mumbai':400},
    'kota':{'delhi':700,'jaipur':300,'udaipur':250,'bhopal':500},
    'ahemdabad':{'udaipur':350,'mumbai':200},
    'mumbai':{'udaipur':400,'ahemdabad':200,'panaji':180,'nanded':500},
    'panaji':{'mumbai':180,'bengaluru':560},
    'bengaluru':{'panaji':560,'kochi':220,'chennai':180},
    'kochi':{'bengaluru':220},
    'chennai':{'bengaluru':180,'vishakhapatnam':200,'chennai':0},
    'vishakhapatnam':{'chennai':200,'bhubaneshwar':575},
    'bhubaneshwar':{'vishakhapatnam':575,'bhopal':250,'kolkata':700},
    'bhopal':{'bhubaneshwar':250,'nagpur':375,'kota':500,'agra':800},
    'nagpur':{'bhopal':75,'nanded':50},
    'nanded':{'nagpur':450,'mumbai':500},
    'kolkata':{'bhubaneshwar':700,'patna':500,'kolkata':0},
    'patna':{'kolkata':500,'lucknow':400,'agra':600},
    'agra':{'bhopal':800,'delhi':100,'lucknow':250,'patna':600},
    'lucknow':{'patna':400,'delhi':300,'agra':250},
    
  }, summation: sum, zero: 0,comparator: comparator);

List<List<String> > shortestPath=[];
shortestPath.length=5;
List<String> d_city=['','delhi','dehradun','chennai','kolkata'];

   shortestPath[1] = graph.shortestPath('$city', 'delhi');
   shortestPath[2] = graph.shortestPath('$city', 'dehradun');
   shortestPath[3] = graph.shortestPath('$city', 'chennai');
   shortestPath[4] = graph.shortestPath('$city', 'kolkata');

  dynamic f_shortest= shortestPath[1];
  List<int> wt=[];
  wt.length=5;
   wt[1]= graph.weightAlong(shortestPath[1]);
   wt[2]= graph.weightAlong(shortestPath[2]);
   wt[3]= graph.weightAlong(shortestPath[3]);
   wt[4]= graph.weightAlong(shortestPath[4]);


  int f_wt= 100000;

  for(int i=1;i<=4;i++){
    if(wt[i] <= f_wt) {
      f_wt = wt[i];
      f_shortest = shortestPath[i];
      f_cty= d_city[i];
    }
  }
  // get_fname();

  List<dynamic> r_list=[];
  r_list.length=3;
  r_list[0]=f_wt;
  r_list[1]=f_shortest;
  r_list[2]=f_cty;
  return r_list;
}

