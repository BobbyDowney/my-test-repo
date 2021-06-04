// Taken from Firebase Profile tutorial
// https://github.com/md-weber/firebase_profile_tutorial/blob/part_2/lib/views/profile/avatar.dart

import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String? avatarUrl;
  final Function()? onTap;

  const Avatar({this.avatarUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: avatarUrl == null
            ? CircleAvatar(
                radius: 50.0,
                child: Icon(Icons.photo_camera),
              )
            : CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(avatarUrl!),
              ),
      ),
    );
  }
}
