import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
import 'package:safe_chair2/model/l10nType.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';

class ScanConnectIndicator {
  static show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Color primaryColor = Theme.of(context).primaryColor;
        return Container(
          child: Center(
            child: Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                // color: Colors.black45,
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(primaryColor)),
                  ),
                  SizedBox(height: 20,),
                  FlatButton(
                    child: Text(AppLocalizations.of(context).uiText(UiType.cancel_btn)),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      ChairControlInfo chairControlInfo = Provider.of<ChairControlInfo>(context);
                      chairControlInfo.cancelScanConnect();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static close(BuildContext context) {
    Navigator.pop(context);
  }
}
