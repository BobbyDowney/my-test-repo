import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen() : Super();

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Sign in page')]
        )
      )
    );
  }
}