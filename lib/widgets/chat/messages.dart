import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../messageBubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapShot) {
          if (futureSnapShot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, chatSnapshots) {
              if (chatSnapshots.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              final chatSnap = chatSnapshots.data.documents;
              return ListView.builder(
                  reverse: true,
                  itemCount: chatSnap.length,
                  itemBuilder: (context, index) {
                    return MessageBubble(
                      chatSnap[index]['text'],
                      chatSnap[index]['userId'] == futureSnapShot.data.uid,
                      chatSnap[index]['userId'],
                      chatSnap[index]['userImage']
                    );
                  });
            },
          );
        });
  }
}
