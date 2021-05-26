import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  /*
  This creates the widget that displays at the bottom of each screen of the app.
  The currentIndex is the icon that is highlighted, and tabs are the routes that
  the user is taken to when pressing the corresponding button.
  */

  NavigationBar(this.currentIndex);

  final int currentIndex;
  var tabs = ['/homepage', '/usersearch', '/profile'];

  @override
  Widget build(BuildContext context){
    return BottomNavigationBar(
      currentIndex: currentIndex, // this will be set when a new tab is tapped
      onTap: (index) {
        if (index != currentIndex){
          Navigator.pushReplacementNamed(context, tabs[index]);
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.search),
          label: 'User Search',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile'
        )
      ],
    );
  }
}