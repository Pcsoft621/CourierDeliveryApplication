import 'package:easy_go/models/auth/new_user_info.dart';
import 'package:easy_go/screens/common/chat/chat_room_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllChats extends StatefulWidget {
  const AllChats({super.key});

  @override
  State<AllChats> createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: SafeArea(
        child:Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: "Name"
                ),
              ),
              SizedBox(height: 20,),
              CupertinoButton(child: Text('search'), onPressed: (){
                setState(() {
                  
                });
              }),
              SizedBox(height: 20,),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("users").
                where("firstName",isEqualTo: searchController.text).snapshots(),
                builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.active){
                    if(snapshot.hasData){
                      QuerySnapshot dataSnapshot=snapshot.data as 
                      QuerySnapshot;
                      if(dataSnapshot.docs.length>0){
                        Map<String,dynamic> userMap=dataSnapshot.docs[0]. 
                        data() as Map<String,dynamic>;
                        NewUserInfo searchedUser=NewUserInfo.fromMap(userMap);
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(searchedUser.profileUrl),
                          ),
                          title: Text(searchedUser.firstName),
                          subtitle: Text(searchedUser.isTransporter.toString()),
                          onTap: (){
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                return ChatRoom();
                              }
                            )
                            );
                          },
                      );
                      }
                      else{
                        return Text("No results found");  
                      }
                    }
                    else if(snapshot.hasError){
                      return Text("An Error Occured");
                    }
                    else{
                      return Text("No results found");
                    }

                  }
                  else{
                    return CircularProgressIndicator();
                  }
                },
                ),
            ],
          ),
        )
        ),
    );
  }
}
