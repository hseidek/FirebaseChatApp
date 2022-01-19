import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message,this.isMe,{required this.key});

    final String message;
    final bool isMe ;
    final Key key;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe?MainAxisAlignment.end:MainAxisAlignment.start,// here to differentiate on the left other user on right me
      children: [
        Container(
          decoration: BoxDecoration(
              color: isMe? Colors.grey[300]:Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                bottomRight: isMe?Radius.circular(0):Radius.circular(12),// here to delete the radius from 1 side from the four to appear as chat dialogue for me
                bottomLeft: !isMe?Radius.circular(0):Radius.circular(12),// here to delete the radius from 1 side from the four to appear as chat dialogue  from other user
              )),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            message,
            style: TextStyle(
                color:isMe ? Colors.black:Theme.of(context).accentTextTheme.headline1!.color),
          ),
        ),
      ],
    );
  }
}
