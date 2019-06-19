import 'package:flutter/material.dart';
import 'package:safe_chair2/views/chair_page/chair_page.dart';
import 'package:safe_chair2/views/help_page/help_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:safe_chair2/ui_components/toast.dart';
import 'components/welldon_tab_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabIndex = 0;

  void openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show(context, msg: '不能打开网址');
    }
  }

  void _changeTabPage(int index) {
    if (index == 1) {
      print('launch web');
      openUrl('http://www.welldon.net.cn/');
      return;
    }
    if (index == 2) {
      print('launch tmall');
      openUrl('http://welldonqcyp.m.tmall.com/');
      return;
    }
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: IndexedStack(
        index: _tabIndex,
        children: <Widget>[
          ChairPage(),
          Container(),
          Container(),
          HelpPage(),
        ],
      ),
      bottomNavigationBar: WelldonTabBar(
        onTap: _changeTabPage,
      ),
    );
  }
}
