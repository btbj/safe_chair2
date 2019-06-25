// import 'package:flutter/material.dart';
// import 'package:flutter_easyrefresh/easy_refresh.dart';

// class RefreshBox extends StatelessWidget {
//   final GlobalKey<EasyRefreshState> refreshkey;
//   final GlobalKey<RefreshHeaderState> headerKey;
//   final GlobalKey<RefreshFooterState> footerKey;
//   final Widget child;
//   final Function onRefresh;
//   final Function loadMore;

//   RefreshBox({this.refreshkey, this.headerKey, this.footerKey, @required this.child, @required this.onRefresh, @required this.loadMore});
  

//   @override
//   Widget build(BuildContext context) {
//     return EasyRefresh(
//       key: refreshkey,
//       behavior: ScrollOverBehavior(),
//       refreshHeader: ClassicsHeader(
//         key: headerKey,
//         refreshText: '下拉刷新',
//         refreshReadyText: '放开刷新',
//         refreshingText: '获取中...',
//         refreshedText: '已刷新',
//         bgColor: Colors.transparent,
//         textColor: Colors.black,
//       ),
//       refreshFooter: ClassicsFooter(
//         key: footerKey,
//         loadText: '上拉加载',
//         loadReadyText: '放开加载',
//         loadingText: '加载中...',
//         loadedText: '已加载',
//         noMoreText: '没有更多',
//         bgColor: Colors.transparent,
//         textColor: Colors.black,
//       ),
//       child: child,
//       onRefresh: onRefresh,
//       loadMore: loadMore,
//     );
//   }
// }

