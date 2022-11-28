import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_go/screens/common/chat/all_chats.dart';
import 'package:easy_go/screens/common/help.dart';
import 'package:easy_go/screens/consumer/post_courier_screen.dart';
import 'package:easy_go/screens/home/consumer_menu.dart';
import 'package:easy_go/screens/home/transporter_menu.dart';
import 'package:easy_go/screens/transporter/track_transporter_curr_trans.dart';
//import 'package:easy_go/screens/transporter/transporter_next_details.dart';
import 'package:easy_go/util/firebase.dart';
import 'package:flutter/material.dart';
import 'package:easy_go/screens/transporter/traveling_Details_Screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_go/screens/consumer/reciversList_Screen.dart';
import 'package:easy_go/screens/transporter/current_transaction_list_transporter.dart';
import 'package:easy_go/screens/consumer/specific_courier_details_scren.dart';
import 'package:easy_go/screens/consumer/current_tran_sender.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreenPage(),
      
  
    );
  }
}

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});
  
  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
    int activePage=1;
  //late PageController _pageController;
  final db=firestore;
  bool isTransporter=false;
  final uid = auth.currentUser!.uid;
  late Map<String, dynamic> user;
  void initState() {
  super.initState();
  initUser();
  
  }
  Future<void> initUser ()async
  {
    
     final docRef = db.collection("users").doc(uid);
     
     setState(() {
        docRef.get().then((DocumentSnapshot doc) {
        setState(() {
          user = doc.data() as Map<String, dynamic>;    
          isTransporter =user["isTransporter"];
          print(isTransporter);
        });

      });

     });  
  }
  

  List cardList=[
    Item1(),Item2(),
    
  ];
List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
    
    floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
                context,
          MaterialPageRoute(builder: (context) => const HelpPage()),);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.help),
      ),
    appBar: AppBar(title: Text('EasyGo'),),
    //floatingActionButton: FloatingActionButton,
    drawer: Drawer(
    child: isTransporter==true?Transportermenu():ConsumerMenu()),
    body: Container(
      child:Column(
              children: [
              CarouselSlider(
                options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                  });
                },
                ),
              items: cardList.map((card){
                return Builder(
                  builder:(BuildContext context){
                    return SizedBox(
                      height: MediaQuery.of(context).size.height*0.30,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.blueAccent,
                        child: card,
                      ),
                    );
                  }
                );
              }).toList(),
              ),
              Container(
                height: 515,
                child: Image.asset('assets/images/bluebghome.png'),
              ),
              
            ],
          
     ),
    )
   );
  }
}


class Item1 extends StatelessWidget {
  const Item1({Key? key}) : super(key: key);
@override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.3, 1],
          colors: [Colors.white,Colors.white,]
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Image.asset(
              
                'assets/images/carsole1.png',
                 //height: 180,
                fit:BoxFit.fitHeight,
            
              ), 
        ],
      ),
    );
  }
}

//
class Item2 extends StatelessWidget {
  const Item2({Key? key}) : super(key: key);
@override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.3, 1],
          colors: [Colors.white,Colors.white,]
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Image.asset(
              
                'assets/images/finalredcarsol.png',
                 //height: 180,
                fit:BoxFit.fitHeight,
            
              ), 
        ],
      ),
    );
  }
}