import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_go/screens/common/chat/all_chats.dart';
import 'package:easy_go/screens/common/help.dart';
import 'package:easy_go/screens/consumer/post_courier_screen.dart';
import 'package:easy_go/screens/home/transporter_menu.dart';
import 'package:easy_go/screens/transporter/track_transporter_curr_trans.dart';
import 'package:easy_go/screens/transporter/transporter_next_details.dart';
import 'package:easy_go/util/firebase.dart';
import 'package:flutter/material.dart';
import 'package:easy_go/screens/transporter/traveling_Details_Screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_go/screens/consumer/reciversList_Screen.dart';
import 'package:easy_go/screens/transporter/current_transaction_list_transporter.dart';
import 'package:easy_go/screens/consumer/specific_courier_details_scren.dart';
import 'package:easy_go/screens/consumer/current_tran_sender.dart';
import 'package:easy_go/screens/consumer/requests_from_transporters.dart';
class ConsumerMenu extends StatefulWidget {
  const ConsumerMenu({super.key});

  @override
  State<ConsumerMenu> createState() => _ConsumerMenuState();
}

class _ConsumerMenuState extends State<ConsumerMenu> {
  bool isSwitched=false;
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
    DrawerHeader(
               padding: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
               child: Align(
                alignment: FractionalOffset.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                      
                      SizedBox(height: 5),
                      Row(
                        children:[
                      CircleAvatar(
                              radius: 30,
                     backgroundImage: AssetImage(''),
                      ),
                    Spacer(),
                     Text("Active Status",
                            style: TextStyle(fontSize: 14,color: Colors.white,
                  fontWeight: FontWeight.w600,fontStyle: FontStyle.italic )),
                      Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                print(isSwitched);
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
        ],
      ),
                     SizedBox(height: 12),
                     Text("Name",
                            style: TextStyle(fontSize: 16,color: Colors.black,
                  fontWeight: FontWeight.w600,fontStyle: FontStyle.italic )),
                     Row(
                      children:[
                     Text("pcsoft621@gmail.com",
                            style: TextStyle(fontSize: 16,color: Colors.black,
                  fontWeight: FontWeight.w600 )),

                  Spacer(),
                  CircleAvatar(
                    child:IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.white,
                        onPressed: (){},
                        )
                        
                     )
                   
                 ],
              ),
             
                 





                  ],
               )
             ),
            ),
    
     const Divider(thickness: .06, color: Color.fromARGB(255,30,29,29)),
      
      ListTile(
        
        leading: const Icon(Icons.notifications),
        title: const Text('My Requests', 
                     style: TextStyle(color: Colors.black)),
         onTap: () {
             // Add Navigation logic here
            Navigator.push(context,MaterialPageRoute(
              builder: (context) => const RequestsFromTransporters()
            )); 

        },
      ),
      ListTile(
        
        leading: const Icon(Icons.track_changes),
        title: const Text('Current Transaction Process', 
        ),
        onTap: () {
           /* Navigator.push(context,MaterialPageRoute(
              builder: (context) => const TrackSenderTransaction()
            ));
*/
            
        }
      ),
      ListTile(
        
        leading: const Icon(Icons.chat),
        title: const Text('Chat', 
        ),
        onTap: () {
          
          Navigator.push(context,MaterialPageRoute(
              builder: (context) => const AllChats()
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
      ]);
  }
}