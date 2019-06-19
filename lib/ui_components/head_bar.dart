import 'package:flutter/material.dart';
import 'package:safe_chair2/views/setting_pages/setting/setting.dart';

class HeadBar extends StatelessWidget {
  final String title;
  HeadBar({this.title});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    Widget _buildSettingBtn() {
      return Container(
        width: 90,
        child: FlatButton(
          child: Icon(
            Icons.settings,
            color: primaryColor,
          ),
          onPressed: () {
            print('setting');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingPage(),
              ),
            );
          },
        ),
      );
    }

    Widget _buildMessageBtn() {
      // return Container(
      //   width: 90,
      //   child: FlatButton(
      //     child: Icon(
      //       Icons.message,
      //       color: primaryColor,
      //     ),
      //     onPressed: () {
      //       print('message');
      //     },
      //   ),
      // );
      return Container(
        width: 90,
        height: 20,
      );
    }

    Widget _buildTitle() {
      return Text(title, style: TextStyle(color: primaryColor, fontSize: 16));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildSettingBtn(),
        _buildTitle(),
        _buildMessageBtn(),
      ],
    );
  }
}
