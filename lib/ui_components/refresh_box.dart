import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class RefreshBox extends StatelessWidget {
  final Widget child;
  final Function onRefresh;
  final Function onLoad;

  RefreshBox({@required this.child, @required this.onRefresh, @required this.onLoad});
  

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: ClassicalHeader(
        refreshText: '下拉刷新',
        refreshReadyText: '放开刷新',
        refreshingText: '获取中...',
        refreshedText: '已刷新',
        bgColor: Colors.transparent,
        textColor: Colors.black87,
        showInfo: false,
      ),
      footer: ClassicalFooter(
        loadText: '上拉加载',
        loadReadyText: '放开加载',
        loadingText: '加载中...',
        loadedText: '加载完成',
        noMoreText: '没有更多',
        bgColor: Colors.transparent,
        textColor: Colors.black87,
        showInfo: false,
      ),
      child: child,
      onRefresh: onRefresh,
      onLoad: onLoad,
    );
  }
}

