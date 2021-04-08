import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_login_flutter/app/home/tab_item.dart';

class CupertinoHomeScafold extends StatelessWidget {
  const CupertinoHomeScafold({
    Key key,
    @required this.currentTab,
    @required this.onSelectTab,
  }) : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _buildItem(TabItem.jobs),
          _buildItem(TabItem.entries),
          _buildItem(TabItem.accounts),
        ],
        onTap: (index) => onSelectTab(
          TabItem.values[index],
        ),
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
        builder: (context){
          return Container();
        },
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem itemTab) {
    final tabData = TabItemData.allTabs[itemTab];
    final color = currentTab == itemTab ? Colors.indigo : Colors.grey;
    return BottomNavigationBarItem(
      icon: Icon(tabData.icon, color: color),
      label: tabData.label,
    );
  }
}
