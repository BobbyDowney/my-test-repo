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
  String? _avatarUrl;
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    getAvatarUrl(firebaseUser).then((value) {
      setState(() {
        _avatarUrl = value;
      });
    });
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Avatar(
            avatarUrl: _avatarUrl,
            onTap: () async {
              ImagePicker picker = ImagePicker();
              print("Selection");
              PickedFile? image =
                  await picker.getImage(source: ImageSource.gallery);

              // Storing that image file
              print("Picture picked");
              uploadProfilePicture(image!.path, firebaseUser);
              print("Uploaded picture");
            },
          ),
          Text(firebaseUser!.email.toString()),
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

Future<String?> getAvatarUrl(User? firebaseUser) async {
  // Check to see if they have a google profile image or some other one
  // Overwrite with any image from our database
  // if neither, return null for basic profile picture

  // Making asumption that image has already been chosen
  String? rval;
  FirebaseStorage storage =
      FirebaseStorage.instanceFor(bucket: "gs://contra-dev-946ab.appspot.com");
  await storage
      .ref()
      .child("user/profile/${firebaseUser!.uid}")
      .getDownloadURL()
      .then((value) {
    rval = value;
  });

  // if (firebasePicture != null) return firebasePicture;
  // print("Should not run");
  // if (firebaseUser.photoURL != null) return firebaseUser.photoURL;

  return rval;
}

Future<void> uploadProfilePicture(String filePath, User? firebaseUser) async {
  File file = File(filePath);

  try {
    await FirebaseStorage.instanceFor(
            bucket: "gs://contra-dev-946ab.appspot.com")
        .ref("user/profile/${firebaseUser!.uid}")
        .putFile(file);
    print("Successfully put file");
  } on FirebaseException catch (e) {
    print("Threw exception $e");
  }
}
