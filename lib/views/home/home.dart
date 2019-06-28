import 'package:flutter/material.dart';
import 'package:safe_chair2/views/chair_page/chair_page.dart';
import 'package:safe_chair2/views/help_page/help_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:safe_chair2/ui_components/toast.dart';
import 'components/welldon_tab_bar.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
import 'package:safe_chair2/providers/app_info.dart';
import 'package:safe_chair2/ui_components/alert_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChairControlInfo chairControlInfo = Provider.of<ChairControlInfo>(context);
    AppInfo appInfo = Provider.of<AppInfo>(context);
    return HomeRoot(
      appInfo: appInfo,
      chairControlInfo: chairControlInfo,
    );
  }
}

class HomeRoot extends StatefulWidget {
  final ChairControlInfo chairControlInfo;
  final AppInfo appInfo;
  HomeRoot({@required this.appInfo, @required this.chairControlInfo});

  @override
  _HomeRootState createState() => _HomeRootState();
}

class _HomeRootState extends State<HomeRoot> {
  int _tabIndex = 0;

  @override
  void initState() {
    this.widget.appInfo.initLang();
    this.widget.chairControlInfo.alertSubject.listen((alertType) {
      Navigator.popUntil(context, (route) => route.settings.isInitialRoute);
      this._changeTabPage(0);
      AlertView.show(context, alertType);
    });
    super.initState();
  }

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
      backgroundColor: Colors.black,
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
        currentIndex: _tabIndex,
        onTap: _changeTabPage,
      ),
    );
  }
}
