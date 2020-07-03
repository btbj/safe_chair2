import 'dart:async';
import 'package:flutter/material.dart';
import 'package:safe_chair2/model/TemperatureMonitor.dart';
import 'package:safe_chair2/views/chair_page/chair_page.dart';
import 'package:safe_chair2/views/help_page/help_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:safe_chair2/ui_components/toast.dart';
import 'components/welldon_tab_bar.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
import 'package:safe_chair2/providers/app_info.dart';
import 'package:safe_chair2/ui_components/alert_view.dart';
import 'package:safe_chair2/util/notification_manager.dart';
import 'package:safe_chair2/model/ChairState.dart';
import 'package:safe_chair2/util/service.dart' as service;

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
  Timer leaveAlertTimer;
  Timer installErrAlertTimer;
  NotificationManager notificationManager = NotificationManager();
  bool _hasPushedInstallError = false;
  bool _hasPushedTempError = false;
  bool _hasPushedBatteryError = false;

  @override
  void initState() {
    this.notificationManager.init();
    this.widget.appInfo.initLang();
    this.widget.chairControlInfo.alertSubject.listen((_) {
      this.checkChairState();
    });
    this
        .widget
        .chairControlInfo
        .cancelAllAlertSubject
        .listen((cancelAll) async {
      if (cancelAll) {
        this.widget.chairControlInfo.cancelAllAlertSubject.add(false);
        await this.notificationManager.cancelAll();
        this.leaveAlertTimer?.cancel();
        this.installErrAlertTimer?.cancel();
      }
    });
    super.initState();
  }

  void checkChairState() async {
    ChairState chairState = this.widget.chairControlInfo.chairState;
    await service.request('/api/error', data: {
      'error': '###chair state:: ${chairState.toString()}',
    });
    if (chairState == null) return;
    TemperatureMonitor temperatureMonitor = this.widget.chairControlInfo.temperatureMonitor;
    
    if (chairState.babyInCar) {
      await this.setTimer(AlertType.babyInCarWhenLeaving);
      await service.request('/api/error', data: {
        'error': '###Reset Timer',
      });
    } else {
      await this.stopAlertTimer(AlertType.babyInCarWhenLeaving);
      await service.request('/api/error', data: {
        'error': '###Stop Timer',
      });
      return;
    }

    if (!chairState.allClear && !this._hasPushedInstallError) {
      this._hasPushedInstallError = true;
      await setTimer(AlertType.installErr);
      return;
    } else if (chairState.allClear) {
      this._hasPushedInstallError = false;
      this.stopAlertTimer(AlertType.installErr);
    }

    if (temperatureMonitor != null) {
      if (temperatureMonitor.highOn &&
          temperatureMonitor.highLimit < chairState.temperature &&
          !this._hasPushedTempError) {
        // 高温警报
        this.navigateBack();
        AlertView.show(context, AlertType.highTemp);
        return;
      } else if (temperatureMonitor.lowOn &&
          temperatureMonitor.lowLimit > chairState.temperature &&
          !this._hasPushedTempError) {
        // 低温警报
        this.navigateBack();
        AlertView.show(context, AlertType.highTemp);
        return;
      } else if (temperatureMonitor.lowLimit < chairState.temperature &&
          temperatureMonitor.highLimit > chairState.temperature &&
          this._hasPushedTempError) {
        // 温度警报重置
        this._hasPushedTempError = false;
      }
    }

    if (chairState.battery < 10 && !this._hasPushedBatteryError) {
      this.navigateBack();
      this._hasPushedBatteryError = true;
      AlertView.show(context, AlertType.lowBattery);
      return;
    }
  }

  Future setTimer(AlertType alertType) async {
    /// 每次检查座椅状态时都设置一个timer
    await this.stopAlertTimer(alertType);
    await this.notificationManager.schedule(context, alertType);
    // print('schedule $alertType');
    if (alertType == AlertType.babyInCarWhenLeaving) {
      this.leaveAlertTimer?.cancel();
      this.leaveAlertTimer = Timer(Duration(seconds: 150), () async {
        this.navigateBack();
        AlertView.show(context, alertType);
        this.widget.chairControlInfo.clearChairState();
        this.widget.chairControlInfo.disconnect();
        await service.request('/api/error', data: {
          'error': '###show disconnect alert::now',
        });
      });
    } else if (alertType == AlertType.installErr) {
      this.installErrAlertTimer?.cancel();
      this.installErrAlertTimer = Timer(Duration(seconds: 120), () async {
        this.navigateBack();
        AlertView.show(context, alertType);
      });
    }
    setState(() {}); // 确保Timer被重置
  }

  Future stopAlertTimer(AlertType alertType) async {
    await this.notificationManager.cancel(alertType);
    if (alertType == AlertType.babyInCarWhenLeaving) {
      this.leaveAlertTimer?.cancel();
    } else if (alertType == AlertType.installErr) {
      this.installErrAlertTimer?.cancel();
    }
    return;
  }

  void navigateBack() {
    Navigator.popUntil(context, (route) => route.settings.isInitialRoute);
    this._changeTabPage(0);
  }

  void openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show(context, msg: '不能打开网址');
    }
  }

  void _changeTabPage(int index) {
    if (index == _tabIndex) return;
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
    if (index == 3) {}
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
