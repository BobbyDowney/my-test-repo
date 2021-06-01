import 'package:flutter/material.dart';
import 'navigationBar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_service.dart';


class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  @override
  Widget build(BuildContext context){
    final firebaseUser = context.watch<User?>();
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Text('Profile page'),
                  Text(firebaseUser!.email.toString()),
                  //Text(firebaseUser.displayName.toString()),
                  //Text(firebaseUser.phoneNumber.toString()),
                  Text(firebaseUser.toString()),
                  ElevatedButton(
                    child: Text('Log out'),
                    onPressed: () {
                      context.read<AuthenticationService>().signOut();
                      Navigator.of(context).pushReplacementNamed('/signin');
                    }
                  )
                ]
            )
        ),
        bottomNavigationBar: NavigationBar(2)
    );
  }
}

