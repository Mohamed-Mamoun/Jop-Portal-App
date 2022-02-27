import 'package:flutter/material.dart';
import 'package:jop_portal/Screens/JobSeeker/Freelancing.dart';
import 'package:jop_portal/Screens/JobSeeker/Job%20Fields/Art.dart';
import 'package:jop_portal/Screens/JobSeeker/Job%20Fields/Business.dart';
import 'package:jop_portal/Screens/JobSeeker/Job%20Fields/Education.dart';
import 'package:jop_portal/Screens/JobSeeker/Job%20Fields/Engineering.dart';
import 'package:jop_portal/Screens/JobSeeker/Job%20Fields/Law.dart';
import 'package:jop_portal/Screens/JobSeeker/Job%20Fields/communication.dart';
import 'package:jop_portal/Screens/JobSeeker/Job%20Fields/medicine.dart';
import 'package:jop_portal/Screens/JobSeeker/Job%20Fields/technology.dart';
import 'package:jop_portal/Screens/JobSeeker/home.dart';
import 'package:jop_portal/Screens/freelancing_jobs.dart';
import 'package:jop_portal/helpers/Styles/style.dart';

class tabbar extends StatelessWidget {
  const tabbar({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: primaryColor,
            title: const Text('Freelancing'),
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              tabs: [
                Tab(
                    child: Icon(
                  Icons.person,
                )),
                Tab(child: Icon(Icons.group)),
              ],
            ),
          ),
          body: TabBarView(children: [
            const Freelancing(),
            Freelancing_jobs(),
          ]),
        ));
  }
}

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  String searchkey = '';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 9,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: primaryColor,
            title: const TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              unselectedLabelColor: Colors.white,
              indicatorWeight: 5,
              tabs: [
                Tab(
                  text: 'All',
                ),
                Tab(
                  child: Text('Education'),
                ),
                Tab(
                  child: Text('Software'),
                ),
                Tab(
                  child: Text('Engineering'),
                ),
                Tab(
                  child: Text('Business & Administration'),
                ),
                Tab(
                  child: Text('Law'),
                ),
                Tab(
                  child: Text('Communication'),
                ),
                Tab(
                  child: Text('Medicine'),
                ),
                Tab(
                  child: Text('Arts'),
                ),
              ],
            ), 
            
          ),
          body:  const TabBarView(children: [
            Home(),
            Education(),
            Tech(),
            Engineering(),
            Business(),
            Law(),
            Communication(),
            Medicine(),
            Art()
          ]),
        ));
  }
}