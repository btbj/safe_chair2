import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import './menu_nav.dart';
import 'package:safe_chair2/views/setting_pages/chair_intro/chair_intro.dart';
import 'package:safe_chair2/model/Chair.dart';

class ChairIntroBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChairControlInfo _chairControlInfo = Provider.of<ChairControlInfo>(context);
    Chair targetChair = _chairControlInfo.targetChair;
    return MenuNav(
      label: AppLocalizations.of(context).uiText(UiType.chair_intro_title),
      endLabel: targetChair == null ? '' : targetChair.nameText,
      onTap: () {
        print('nav to chair intro');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChairIntroPage(chair: _chairControlInfo.targetChair),
          ),
        );
      },
    );
  }
}