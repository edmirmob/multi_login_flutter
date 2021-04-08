import 'package:flutter/material.dart';
import 'package:multi_login_flutter/app/home/cupertino_home_scafold.dart';
import 'package:multi_login_flutter/app/home/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}


class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.jobs;
  void _select(TabItem tabItem) {

  setState(()=>_currentTab = tabItem);
}
  @override
  Widget build(BuildContext context) {
    return CupertinoHomeScafold(
      currentTab: _currentTab,
      onSelectTab: _select,
    );
  }
}
