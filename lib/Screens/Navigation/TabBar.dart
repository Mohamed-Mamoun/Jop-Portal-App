import 'package:flutter/material.dart';
import 'package:jop_portal/Screens/JobSeeker/Freelancing.dart';
import 'package:jop_portal/Screens/freelancing_jobs.dart';
import 'package:jop_portal/helpers/Styles/style.dart';

class tabbar extends StatefulWidget {
  const tabbar({Key? key}) : super(key: key);

  @override
  _tabbarState createState() => _tabbarState();
}

class _tabbarState extends State<tabbar> {
  @override
  Widget build(BuildContext context) {
    final _pages = <Widget>[];

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: primaryColor,
            title: Text('Freelancing'),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              tabs: [
                Tab(child: Icon(Icons.person,)),
                Tab(child: Icon(Icons.group)),
              ],
            ),
          ),
          body: TabBarView(children: [
            Freelancing(),
            Freelancing_jobs(),
          ]),
        ));
  }
}
