import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../widgets/chat_messages.dart';
import '../widgets/new_message.dart';
final _firebase= FirebaseAuth.instance;
class ChatScreen extends  StatefulWidget{
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotification() async {
    final fcm=FirebaseMessaging.instance;
    await fcm.requestPermission();
 fcm.subscribeToTopic('chat');
  }

  @override
  void initState() {
    super.initState();
    setupPushNotification();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat',
      ),
      actions: [
        IconButton(
            onPressed: (){
FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,color: Theme.of(context).colorScheme.primary,
            ))

      ]),
      body:  Center(
        child: Column(
          children: const [
            Expanded(child: Chat_Messages()),
            NewMessage()
          ],
        ),
      )
    );

}}