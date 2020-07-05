import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String userId;
  final String imageUrl;

  MessageBubble(this.message, this.isMe, this.userId, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12)),
            ),
            width: 140,
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: Firestore.instance
                      .collection('user')
                      .document(userId)
                      .get(),
                  builder: (context, snapShot) {
                    if (snapShot.connectionState == ConnectionState.waiting) {
                      return Text('Loading...');
                    }
                    return Text(
                      snapShot.data['userName'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    );
                  },
                ),
                Text(message,
                    style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).accentTextTheme.title.color)),
              ],
            ),
          ),
        ],
      ),
      Positioned(
          top: -10,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          )),
          
    ],
    overflow: Overflow.visible,
    );
  }
}
