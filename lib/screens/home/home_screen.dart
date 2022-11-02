import 'package:easy_go/screens/common/help.dart';
import 'package:easy_go/screens/consumer/post_courier_screen.dart';
import 'package:easy_go/screens/transporter/track_transporter_curr_trans.dart';
import 'package:easy_go/screens/transporter/transporter_Profile_Screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_go/screens/transporter/traveling_Details_Screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_go/screens/consumer/reciversList_Screen.dart';
import 'package:easy_go/screens/transporter/current_transaction_list_transporter.dart';
import 'package:easy_go/screens/consumer/specific_courier_details_scren.dart';
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
        

    child: ListView(children: [
    DrawerHeader(
      child: Column(
        children: const [
          SizedBox(height: 10),
          Center(
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
          ),
          SizedBox(height: 10),
          Text("Name",
              style: TextStyle(fontSize: 20, )),
          Text("pcsoft621@gmail.com",
              style: TextStyle(fontSize: 20, )),
        ],
      )
    ),
    
     const Divider(thickness: .06, color: Color.fromARGB(255,30,29,29)),
      ListTile(
        
        leading: const Icon(Icons.person),
        title: const Text('My Profile', 
        ),
         onTap: () {
          Navigator.push(context,MaterialPageRoute(
              builder: (context) => const TransporterProfile()
            ));
             // Add Navigation logic here
        },
      ),
      ListTile(
        
        leading: const Icon(Icons.notifications),
        title: const Text('My Requests', 
                     style: TextStyle(color: Colors.black)),
         onTap: () {
             // Add Navigation logic here
            Navigator.push(context,MaterialPageRoute(
              builder: (context) => const CurrentTransactionsForTr()
            )); 

        },
      ),
      ListTile(
        
        leading: const Icon(Icons.track_changes),
        title: const Text('Current Transaction Process', 
        ),
        onTap: () {
            Navigator.push(context,MaterialPageRoute(
              builder: (context) => const Current_tran_Transporter()
            ));

             // Add Navigation logic here
        }
      ),
      ListTile(
        
        leading: const Icon(Icons.chat),
        title: const Text('Chat', 
        ),
        onTap: () {
          
          Navigator.push(context,MaterialPageRoute(
              builder: (context) => const ReciversList()
            ));
             // Add Navigation logic here
        },
      ),
      ListTile(
        
        leading: const Icon(Icons.list),
        title: const Text('Post Courier', 
        ),
        onTap: () {
           Navigator.push(context,MaterialPageRoute(
              builder: (context) => const CourierDetails()
            ));

          //Navigator.pushNamed(context, "otp");
             // Add Navigation logic here
        },
      ),
      ListTile(
        
        leading: const Icon(Icons.money),
        title: const Text('My Earnings', 
        ),
        onTap: () {
             // Add Navigation logic here
        },
      ),
      ListTile(
        
        leading: const Icon(Icons.details),
        title: const Text('Previous Deals', 
        ),
        onTap: () {
             // Add Navigation logic here
        },
      ),
      ListTile(
        leading: const Icon(Icons.subscriptions),
        title: const Text('Send Courier', 
        ),
        onTap: () {
             // Add Navigation logic here
        },
      ),
      ListTile(
        leading: const Icon(Icons.eighteen_up_rating_sharp),
        title: const Text('Ratings', 
        ),
        onTap: () {
             // Add Navigation logic here
             Navigator.push(
                context,
          MaterialPageRoute(builder: (context) => const SpecificCourierDetails()),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.help),
        title: const Text('Help', 
        ),
        onTap: () {
                Navigator.push(
                context,
          MaterialPageRoute(builder: (context) => const HelpPage()),
          );
             // te root use krun hot nsty ka hit mi krun bgitl zal ny call 
             // ky kl nahi ky ny rahude ja tu ata 
        },
      )
      ])),
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