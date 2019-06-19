import 'package:flutter/material.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import 'package:safe_chair2/views/policy/service_policy.dart';

class PolicyRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).messageText(MessageType.register_to_agree),
            style: TextStyle(color: Colors.grey[700], fontSize: 12),
          ),
          GestureDetector(
            child: Text(
              AppLocalizations.of(context).uiText(UiType.policy_nav_text),
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 12),
            ),
            onTap: () {
              print('service policy');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ServicePolicyPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
