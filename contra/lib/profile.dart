import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen() : Super();

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Profile page')]
            )
        )
    );
  }
}