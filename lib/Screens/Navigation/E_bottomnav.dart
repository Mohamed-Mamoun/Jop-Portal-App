import 'package:flutter/material.dart';
import 'package:jop_portal/Components/Styles/style.dart';
import 'package:jop_portal/Screens/Employer/Applicant.dart';
import 'package:jop_portal/Screens/Employer/E_freelancing.dart';
import 'package:jop_portal/Screens/Employer/E_profile.dart';
import 'package:jop_portal/Screens/Employer/jobs.dart';
import 'package:jop_portal/Screens/Navigation/TabBar.dart';


class E_Bottumnav extends StatefulWidget {
  const E_Bottumnav({Key? key}) : super(key: key);

  @override
  _E_BottumnavState createState() => _E_BottumnavState();
}

class _E_BottumnavState extends State<E_Bottumnav> {
  int _currentindex = 0;

  @override
  Widget build(BuildContext context) {
    final _TabPages = <Widget>[Jobs(), E_Profile(), tabbar(), Applicant()];
    final _bottomNavItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.house_outlined, color: primaryColor, size: 30),
          label: 'Jobs'),
      BottomNavigationBarItem(
          icon: Icon(Icons.account_circle, color: primaryColor, size: 30),
          label: 'Profile'),
      BottomNavigationBarItem(
          icon: Icon(Icons.laptop_chromebook, color: primaryColor, size: 30),
          label: 'freelancing'),
      BottomNavigationBarItem(
          icon: Icon(Icons.group, color: primaryColor, size: 30),
          label: 'Applicant'),
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
