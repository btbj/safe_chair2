import 'package:flutter/material.dart';
import 'dart:async';

class Toast {
  static show(BuildContext context,
      {@required String msg, int seconds = 2, IconData icon, double iconSize = 30}) {
    var overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = new OverlayEntry(builder: (context) {
      return buildToastLayout(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            icon == null
                ? SizedBox(height: 0)
                : Icon(icon, color: Colors.white, size: iconSize),
            Text(
              msg,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    });
    var toastView = ToastView(seconds);
    toastView.overlayState = overlayState;
    toastView.overlayEntry = overlayEntry;
    toastView._show();
  }

  static LayoutBuilder buildToastLayout(Widget child) {
    return LayoutBuilder(builder: (context, constraints) {
      return IgnorePointer(
        ignoring: true,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 200,
          ),
          child: Material(
            color: Colors.transparent,
            child: Container(
              child: Container(
                child: child,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              margin: EdgeInsets.only(
                bottom: constraints.biggest.height * 0.4,
                left: constraints.biggest.width * 0.2,
                right: constraints.biggest.width * 0.2,
              ),
            ),
          ),
          alignment: Alignment.bottomCenter,
        ),
      );
    });
  }
}

class ToastView {
  OverlayEntry overlayEntry;
  OverlayState overlayState;
  bool dismissed = false;
  int seconds;
  ToastView(this.seconds);

  _show() async {
    overlayState.insert(overlayEntry);
    await Future.delayed(Duration(seconds: seconds));
    this.dismiss();
  }

  dismiss() async {
    if (dismissed) {
      return;
    }
    this.dismissed = true;
    overlayEntry?.remove();
  }
}
