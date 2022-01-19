import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_application/widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false;

  Future<void> _submitAuthForm(String email, String username, String password,
      bool isLogin, BuildContext ctx) async {
    UserCredential authResult;

    try {
      setState(() {
        isLoading = true;
      });

      if (isLogin) {
        authResult =
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // in this line after the sign up we will store the extra data ( username).
        // will store it using the firestore instance and access the collection ('users') there is no collection named
        // users yet but it will be created on the fly.
        // then will access .doc intead of .add as .add will create everytime an ID automatic
        // and we need to access our existing user ID.
        await FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).set({
          'username': username,
          'email':email

        });
        // our authResult object has a ( user ) object which has a (UID ) field that was genrated for the user by firebase
        // doc(authResult.user!.uid ( this consider only the identifier of the document ) and .set ( is the extra data that we will store)
        // the data in document is consider a map
      }
    } on PlatformException catch (error) {
      var message = 'An Error Occured, Check you Credentails!';

      if (error.message != null) {
        message = error.message!;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));


    } catch (error) {
      print(error);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Auth_Form(_submitAuthForm,isLoading);
  }
}
