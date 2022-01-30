import 'package:flutter/material.dart';
import 'package:jop_portal/JobSeeker/Freelancing.dart';
import 'package:jop_portal/JobSeeker/home.dart';
import 'package:jop_portal/JobSeeker/profile.dart';
import 'package:jop_portal/Navigation/TabBar.dart';
import 'package:jop_portal/Styles/style.dart';

class j_bottomnavbar extends StatefulWidget {
  const j_bottomnavbar({Key? key}) : super(key: key);

  @override
  _j_bottomnavbarState createState() => _j_bottomnavbarState();
}

class _j_bottomnavbarState extends State<j_bottomnavbar> {
  int _currentindex = 0;
  @override
  Widget build(BuildContext context) {
    final _TabPages = <Widget>[
      Home(),
      Profile(),
      tabbar(),
    ];

    final _bottomNavItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: primaryColor,
            size: 30,
          ),
          label: 'Home'),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle,
            color: primaryColor,
            size: 30,
          ),
          label: 'Profile'),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.laptop_chromebook,
            color: primaryColor,
            size: 30,
          ),
          label: 'freelancing'),
    ];
    assert(_TabPages.length == _bottomNavItems.length);
    final bottomnavbar = BottomNavigationBar(
      items: _bottomNavItems,
      currentIndex: _currentindex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentindex = index;
        });
      },
    );
    return Scaffold(
      body: _TabPages[_currentindex],
      bottomNavigationBar: bottomnavbar,
    );
  }
}
