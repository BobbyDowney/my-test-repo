import 'package:flutter/material.dart';
import 'navigationBar.dart';

class UserSearchScreen extends StatefulWidget {
  UserSearchScreen({Key? key}) : super(key: key);

  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('User Search page')]
            )
        ),
        bottomNavigationBar: NavigationBar(1)
    );
  }
}