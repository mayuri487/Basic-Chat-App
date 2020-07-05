import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/chat/messages.dart';
import '../widgets/newMessages.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FlutterChat'),
          actions: [
            DropdownButton(
              icon: Icon(Icons.more_vert,
                  color: Theme.of(context).primaryIconTheme.color),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(width: 8),
                        Text('Log out')
                      ],
                    ),
                  ),
                  value: 'logOut',
                ),
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logOut') {
                  FirebaseAuth.instance.signOut();
                }
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Messages(),
              ),
              NewMessage()
            ],
          ),
        ),
        
            );
  }
}
