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
    return Container();
  }
}
