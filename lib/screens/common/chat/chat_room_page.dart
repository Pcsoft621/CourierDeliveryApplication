import 'package:easy_go/models/auth/new_user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChatRoom extends StatefulWidget {
 /* final NewUserInfo targetUser;
  final ChatRoom chatRoom;
  final UserInfo me;
  */
  const ChatRoom({super.key});
  
  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Container(
        child: Column(
          children: [
            Expanded(child: Container(

            )
            ),
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5
              ),
              child: Row(
                children: [
                  Flexible(child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Message",
                      border: InputBorder.none,
                    ),
                  )),
                  IconButton(onPressed: (){

                  }, icon: Icon(Icons.send))
                ],
              ),
            )

          ],
        ),
      )),
    );
  }
}