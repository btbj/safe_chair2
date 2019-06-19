import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/setting/chair_instruction_info.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import 'package:safe_chair2/ui_components/basic_btn.dart';
import 'package:safe_chair2/ui_components/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChairInstructionInfo>(
        builder: (context, chairInstructionInfo, _) {
      Function onTap;
      String url = chairInstructionInfo.chairInstallVideoUrl;
      if (url != null) {
        onTap = () async {
          print('check video: ' + url);
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            Toast.show(
              context,
              msg: AppLocalizations.of(context)
                  .messageText(MessageType.url_invalid),
            );
          }
        };
      }
      return BasicBtn(
        label:
            AppLocalizations.of(context).uiText(UiType.install_video_btn_text),
        onTap: onTap,
      );
    });
  }
}
