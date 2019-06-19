import 'package:flutter/material.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';


class WelldonTabBar extends StatelessWidget {
  final Function onTap;
  WelldonTabBar({this.onTap});

  Widget _buildBtn({int index, ImageProvider image, Text label}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTap(index);
        },
        child: Container(
          alignment: Alignment.center,
          height: 70,
          // color: Colors.red,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(
                image: image,
                height: 30,
                width: 30,
              ),
              SizedBox(height: 3),
              label,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 10,
    );

    return SafeArea(
      child: Row(
        children: <Widget>[
          _buildBtn(
            index: 0,
            image: AssetImage('lib/assets/img/tab_bar/baby_care.png'),
            label: Text(AppLocalizations.of(context).uiText(UiType.tabbar_chair), style: textStyle),
          ),
          _buildBtn(
            index: 1,
            image: AssetImage('lib/assets/img/tab_bar/welldon.png'),
            label: Text(AppLocalizations.of(context).uiText(UiType.tabbar_website), style: textStyle),
          ),
          _buildBtn(
            index: 2,
            image: AssetImage('lib/assets/img/tab_bar/tmall.png'),
            label: Text(AppLocalizations.of(context).uiText(UiType.tabbar_tmall), style: textStyle),
          ),
          _buildBtn(
            index: 3,
            image: AssetImage('lib/assets/img/tab_bar/help.png'),
            label: Text(AppLocalizations.of(context).uiText(UiType.tabbar_help), style: textStyle),
          ),
        ],
      ),
    );
  }
}
