import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

import 'package:safe_chair2/model/l10nType.dart';
import './message/messages_all.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      print(
          'the local code of $localeName ${locale.countryCode.isEmpty} $locale');
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get title {
    return Intl.message(
      'Hello World',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }

  String uiText(UiType type) {
    return Intl.select(
      type,
      {
        UiType.app_title: 'Welldon',
        UiType.login_btn_text: 'Login',
        UiType.register_nav_text: 'Register',
        UiType.resetpwd_nav_text: 'Forget Pass',
        UiType.register_title: 'Welcome Join',
        UiType.register_btn_text: 'Join',
        UiType.policy_nav_text: 'Service Policy',
        UiType.code_btn_get_code: 'get code',
        UiType.code_btn_seconds: 's to get',
        UiType.resetpwd_title: 'Reset Password',
        UiType.resetpwd_btn: 'Confirm',
        UiType.policy_title: 'Service Policy',
        UiType.tabbar_chair: 'Chair',
        UiType.tabbar_website: 'Website',
        UiType.tabbar_tmall: 'Tmall',
        UiType.tabbar_help: 'Help',
        UiType.chair_title: 'My Chair',
        UiType.help_title: 'Help',
        UiType.setting_title: 'Setting',
        UiType.account_prefix: 'Account: ',
        UiType.version_prefix: 'Version: ',
        UiType.privacy_policy: 'Privacy Policy',
        UiType.chair_manage_title: 'Chair Manage',
        UiType.chair_intro_title: 'Chair Instruction',
        UiType.temperature_setting_title: 'Temperature Setting',
        UiType.password_setting_title: 'Password Setting',
        UiType.logout_btn_text: 'Logout',
        UiType.password_login_account: 'Account',
        UiType.password_new_password: 'New Pass',
        UiType.password_confirm_password: 'Confirm',
        UiType.reset_password_btn_text: 'Modify',
        UiType.high_temperature_alert_label: 'High Temperature Alert',
        UiType.low_temperature_alert_label: 'Low Temperature Alert',
        UiType.temperature_unit_label: 'Temperature Unit',
        UiType.high_temperature_setting_dialog_title:
            'High Temperature Alert Setting',
        UiType.low_temperature_setting_dialog_title:
            'Low Temperature Alert Setting',
        UiType.current_temp_prefix: 'current: ',
        UiType.confirm_btn_text: 'Confirm',
        UiType.chair_name_label: 'Chair Name: ',
        UiType.chair_model_label: 'Chair Model: ',
        UiType.chair_range_label: 'Range: ',
        UiType.chair_install_label: 'Install Method',
        UiType.install_video_btn_text: 'Install video',
        UiType.add_chair_btn_text: 'Add Chair',
        UiType.language_setting_title: 'Language Setting',
        // 座椅控制页面
        UiType.battery_level: 'Chair battery level ',
        UiType.current_temperature: 'Current Temperature',
        UiType.beacon_set_text: 'Chair Set',
        UiType.beacon_notset_text: 'No Chair',
        UiType.beacon_protecting_text: 'Protecting',
        UiType.location_state_text: 'Location',
        UiType.notification_state_text: 'Notification',
        // 警报弹层
        UiType.alert_title: 'Alert',
        UiType.alert_confirm_btn_text: 'Confirm',
        // 设备管理
        UiType.connect_btn: 'Connect',
        UiType.disconnect_btn: 'Disconnect',
        UiType.edit_btn: 'Edit',
        UiType.finish_btn: 'Finish',
        UiType.confirm_btn: 'Confirm',
        UiType.cancel_btn: 'Cancel',
        UiType.edit_device_name_title: 'Edit Device Name',
        UiType.delete_device_dialog_title: 'Delete Device',
        UiType.delete_device_dialog_message: 'Do you want to delete this device?',
      },
      name: 'uiText',
      args: [type],
    );
  }

  String messageText(MessageType type) {
    return Intl.select(
      type,
      {
        MessageType.email_hint: 'enter email',
        MessageType.password_hint: 'enter password',
        MessageType.password_confirm_hint: 'confirm password',
        MessageType.code_hint: 'enter code',
        MessageType.register_to_agree: 'Register for read and agree ',
        MessageType.login_to_agree: 'Login for read and agree ',
        MessageType.url_invalid: 'url is invalid',
        MessageType.no_product: 'no product found',
        // 座椅页面顶部提示
        MessageType.error_none: 'no error',
        MessageType.error_no_signal: 'no chair signal',
        MessageType.error_low_battery: 'low battery level',
        MessageType.error_high_temp: 'temperature too high',
        MessageType.error_low_temp: 'temperature too low',
        MessageType.error_buckle: 'buckle error',
        MessageType.error_lfix: 'left IsoFix error',
        MessageType.error_rfix: 'right IsoFix error',
        MessageType.error_routation: 'routation error',
        MessageType.error_pad: 'pad error',
        MessageType.error_leg: 'support leg error',
        // 警报信息
        MessageType.alert_baby_in_car:
            'You have left while baby is still in car, please check if baby has left!',
        MessageType.alert_install_err:
            'Chair instalation not correct, please check!',
        MessageType.alert_low_battery:
            'Chair battery level critical, please change battery!',
        MessageType.alert_high_temp:
            'Chair temperature too high, please check environment in car!',
        MessageType.alert_low_temp:
            'Chair temperature too low, please check environment in car!',
        // 提示信息
        MessageType.notify_enter:
            'Enter chair region, please open to check chair state',
        MessageType.notify_exit: 'Exit chair region, please check chair state',
      },
      name: 'messageText',
      args: [type],
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

// 苹果系统长按多语言补丁

class CupertinoLocalizationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const CupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return SynchronousFuture<_DefaultCupertinoLocalizations>(
      _DefaultCupertinoLocalizations(locale.languageCode)
    );
  }

  @override
  bool shouldReload(CupertinoLocalizationsDelegate old) => false;

  static CupertinoLocalizationsDelegate delegate = const CupertinoLocalizationsDelegate();
}

class _DefaultCupertinoLocalizations extends CupertinoLocalizations {
  final _en = DefaultCupertinoLocalizations();
  final String _languageCode;

  static Map<String, Map<String, String>> _dict = {
    'en': {
      'alert': 'Alert',
      'copy': 'Copy',
      'paste': 'Paste',
      'cut': 'Cut',
      'selectAll': 'Select all'
    },
    'zh': {
      'alert': '提示',
      'copy': '复制',
      'paste': '粘贴',
      'cut': '剪切',
      'selectAll': '全选'
    }
  };

  _DefaultCupertinoLocalizations(this._languageCode):
    assert(_languageCode != null);

  @override
  String get alertDialogLabel => _get('alert');

  @override
  String get anteMeridiemAbbreviation => _en.anteMeridiemAbbreviation;

  @override
  String get postMeridiemAbbreviation => _en.postMeridiemAbbreviation;

  @override
  String get copyButtonLabel => _get('copy');

  @override
  String get cutButtonLabel => _get('cut');

  @override
  String get pasteButtonLabel => _get('paste');

  @override
  String get selectAllButtonLabel => _get('selectAll');

  @override
  DatePickerDateOrder get datePickerDateOrder => _en.datePickerDateOrder;

  @override
  DatePickerDateTimeOrder get datePickerDateTimeOrder => _en.datePickerDateTimeOrder;

  @override
  String datePickerDayOfMonth(int dayIndex) => _en.datePickerDayOfMonth(dayIndex);

  @override
  String datePickerHour(int hour) => _en.datePickerHour(hour);

  @override
  String datePickerHourSemanticsLabel(int hour) => _en.datePickerHourSemanticsLabel(hour);

  @override
  String datePickerMediumDate(DateTime date) => _en.datePickerMediumDate(date);

  @override
  String datePickerMinute(int minute) => _en.datePickerMinute(minute);

  @override
  String datePickerMinuteSemanticsLabel(int minute) => _en.datePickerMinuteSemanticsLabel(minute);

  @override
  String datePickerMonth(int monthIndex) => _en.datePickerMonth(monthIndex);

  @override
  String datePickerYear(int yearIndex) => _en.datePickerYear(yearIndex);

  @override
  String timerPickerHour(int hour) => _en.timerPickerHour(hour);

  @override
  String timerPickerHourLabel(int hour) => _en.timerPickerHourLabel(hour);

  @override
  String timerPickerMinute(int minute) => _en.timerPickerMinute(minute);

  @override
  String timerPickerMinuteLabel(int minute) => _en.timerPickerMinuteLabel(minute);

  @override
  String timerPickerSecond(int second) => _en.timerPickerSecond(second);

  @override
  String timerPickerSecondLabel(int second) => _en.timerPickerSecondLabel(second);

  String _get(String key) {
    return _dict[_languageCode][key];
  }
}