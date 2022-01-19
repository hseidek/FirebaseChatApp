import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = "";
  final _controller = new TextEditingController();


  void _sendMessage () async{
    // just to close the keyboard after writing the message
    FocusScope.of(context).unfocus();
   final user = await FirebaseAuth.instance.currentUser!;
    // here will use the firestore to add a document ( a Map ) using .add with field name 'text'
    // and assign the _enteredMessage value to that text field
    FirebaseFirestore.instance.collection('chat').add(({
      'text': _enteredMessage, // the text message
      'createdAt': Timestamp.now(),  // to arrange the chat messages by date
      'userID': user.uid,  // to differentiate  messages by me and messages from other user
    }));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'send a message.....'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            // here we want to check if there is no message the button will be dimmed and will activate only once it contain text
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
