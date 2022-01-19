import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_application/screens/auth_screen.dart';
import 'package:social_application/screens/chat_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
           primary: Colors.pink,
            textStyle: TextStyle(
              color: Theme.of(context).primaryColor,
            )
          )
        ),
          textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Colors.pink
        )
      )
      ),
      // FirebaseAuth.instance.authStateChanges() its give a stream and listen to it if we changing the state and validate that
      // states here means signin or signup
      // All this is handled by firebase behind the scene
      // builder here we build what we need whenever the status is changes
      home:StreamBuilder(stream:FirebaseAuth.instance.authStateChanges() ,builder:(ctx,userSnapshot){
        // here we can return different widgets based on userSnapshot
        // userSnapshot.hasData means if the token validation is correct correct signin data or signup
        if (userSnapshot.hasData){
          return ChatScreen();
        }
        // if not have a valid token data will appears the Authscreen
         return AuthScreen();
      }

        ,),
    );
  }
}

