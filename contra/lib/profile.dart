import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'navigationBar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_service.dart';
import './profile/avatar.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Avatar(
              avatarUrl: null,
              onTap: () async {
                ImagePicker picker = ImagePicker();
                PickedFile? image =
                    await picker.getImage(source: ImageSource.gallery);
                print(image!.path);

                // Storing that image file
                uploadProfilePicture(image.path, firebaseUser);

                /*
                // Getting files example
                FirebaseStorage storage = FirebaseStorage.instanceFor(
                    bucket: "gs://contra-dev-946ab.appspot.com");
                Future<String> dURL = storage
                    .ref()
                    .child("user/profile/${firebaseUser!.uid}")
                    .getDownloadURL();
                */
                //setState((){});
              }),
          //Text('Profile page'),
          Text(firebaseUser?.email.toString() ?? ''),
          //Text(firebaseUser.displayName.toString()),
          //Text(firebaseUser.phoneNumber.toString()),
          ElevatedButton(
              child: Text('Log out'),
              onPressed: () {
                context.read<AuthenticationService>().signOut();
                Navigator.of(context).pushReplacementNamed('/signin');
              })
        ])),
        bottomNavigationBar: NavigationBar(2));
  }
}

Future<void> uploadProfilePicture(String filePath, User? firebaseUser) async {
  File file = File(filePath);

  try {
    await FirebaseStorage.instance
        .ref("user/profile/${firebaseUser!.uid}")
        .putFile(file);
  } on FirebaseException catch (e) {
    // e.g, e.code == 'canceled'
  }
}
