import 'package:flutter/material.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';


class WelldonTabBar extends StatelessWidget {
  final Function onTap;
  final int currentIndex;
  WelldonTabBar({@required this.currentIndex, @required this.onTap});

  Widget _buildBtn({int index, Text label}) {
    String fileName = '${index+1}a.png';
    if (this.currentIndex == index) {
      fileName = '${index+1}b.png';
    }
    final String imagePath = 'lib/assets/img/tab_bar/$fileName';
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
                image: AssetImage(imagePath),
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
            label: Text(AppLocalizations.of(context).uiText(UiType.tabbar_chair), style: textStyle),
          ),
          _buildBtn(
            index: 1,
            label: Text(AppLocalizations.of(context).uiText(UiType.tabbar_website), style: textStyle),
          ),
          _buildBtn(
            index: 2,
            label: Text(AppLocalizations.of(context).uiText(UiType.tabbar_tmall), style: textStyle),
          ),
          _buildBtn(
            index: 3,
            label: Text(AppLocalizations.of(context).uiText(UiType.tabbar_help), style: textStyle),
          ),
        ],
      ),
    );
  }
}
