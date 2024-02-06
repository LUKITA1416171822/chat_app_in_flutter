import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Chat_Messages extends StatelessWidget{
  const Chat_Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt',descending: true).snapshots()
        ,builder: (context, chatsnapshots) {
          if(chatsnapshots.connectionState==ConnectionState.waiting)
        return const Center(
          child: CircularProgressIndicator(),
        );
       if(!chatsnapshots.hasData || chatsnapshots.data!.docs.isEmpty) {
         return const Center(
    child: Text(
    'No messages found.'
    ),
    );
       }
       if(chatsnapshots.hasError) {
         return const Center(
    child: Text(
    'No messages found.'
    ),
    );
       }

  final loadedMessages= chatsnapshots.data!.docs;
    return ListView.builder(padding: const EdgeInsets.only(
      bottom: 40 ,
left: 13 ,
      right:13
    ),
      reverse: true,
      itemCount:loadedMessages.length,itemBuilder: (context, index) {
      final chatMessage= loadedMessages[index].data();
      final nextMessage=index+1 <loadedMessages.length ?loadedMessages[index+1].data():null;
      final currentMessageId=chatMessage['userId'];
      final currentMessageUserId=chatMessage['userId'];
      final nextMessageUserId=nextMessage!=null ?nextMessage['userId']:null;
      final nextuserequal=nextMessageUserId==currentMessageUserId;
      if(nextuserequal) {
        return MessageBubble.next(message: chatMessage['text'], isMe:authenticatedUser.uid == currentMessageUserId);
      }
  else{
     return MessageBubble.first(userImage: chatMessage['userImage'] , username: chatMessage['username'],
        message: chatMessage['text'],
        isMe: authenticatedUser.uid == currentMessageUserId);
      }
      } ,);


    },);



  }}