import 'package:flutter/material.dart';
import 'package:multi_login_flutter/app/home/account/account_page.dart';
import 'package:multi_login_flutter/app/home/cupertino_home_scafold.dart';
import 'package:multi_login_flutter/app/home/jobs/jobs_page.dart';
import 'package:multi_login_flutter/app/home/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.jobs;
  void _select(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

    Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.jobs: (_) => JobsPage(),
      TabItem.entries: (_) => Container(),
      TabItem.accounts: (_) => AccountPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoHomeScafold(
      currentTab: _currentTab,
      onSelectTab: _select,
      widgetBuilders: widgetBuilders,
    );
  }
}
