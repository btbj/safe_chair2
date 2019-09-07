import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import 'package:safe_chair2/providers/app_info.dart';
// import 'package:safe_chair2/views/policy/service_policy.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:safe_chair2/config/service_url.dart' show servicePolicyPage;

class PolicyRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            AppLocalizations.of(context)
                .messageText(MessageType.login_to_agree),
            style: TextStyle(color: Colors.grey[700], fontSize: 12),
          ),
          GestureDetector(
            child: Text(
              AppLocalizations.of(context).uiText(UiType.policy_nav_text),
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 12),
            ),
            onTap: () async {
              AppInfo appInfo = Provider.of<AppInfo>(context);
              String langCode = appInfo.isEN ? 'en' : 'zh';
              final url = servicePolicyPage + '?lang=$langCode';
              print('service policy: $url');
              // NavManager.push(context, ServicePolicyPage());
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ServicePolicyPage(),
              //   ),
              // );
              if (await canLaunch(url)) {
                launch(url);
              }
            },
          )
        ],
      ),
    );
  }
}
