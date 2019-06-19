import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:safe_chair2/config/service_url.dart' show serviceUrl;
import 'package:intl/intl.dart';

bool checkEnglish() {
  final String currentLanguageCode = Intl.getCurrentLocale();
  final String shortLocaleCode = Intl.shortLocale(currentLanguageCode);
  // print('$currentLanguageCode $shortLocaleCode');
  return shortLocaleCode != 'zh';
}

Future request(String apiPath, {@required Map data}) async {
  bool isEN = checkEnglish();

  try {
    print('开始获取数据..............');
    Response response;
    Dio dio = new Dio();
    dio.options.baseUrl = serviceUrl;
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;
    if (isEN) {
      data['lang'] = 'en';
    }
    print('url: $serviceUrl$apiPath, data: $data');
    response = await dio.post(apiPath, data: data);
    print(response);
    return response.data;
    
  } on DioError catch(e) {
    print(e.message);
    String message = isEN ? 'Unknown Error' : '未知错误';
    if (e.type == DioErrorType.RESPONSE) {
      String prefix = isEN ? 'Server Error' : '服务器错误';
      message = '$prefix [${e.response.statusCode}]';
    }

    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      message = isEN ? 'Connect Timeout' : '连接超时';
    }
    if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      message = isEN ? 'Receive Timeout' : '接收超时';
    }

    return {
      'success': false,
      'message': message,
    };
  } catch (e) {
    print('ERROR:===========>$e');
    return {
      'success': false,
      'message': '${e.toString()}',
    };
  }
}

Future uploadFile({@required File img}) async {
  try {
    print('开始上传图片..............');
    // return null;
    Response response;
    Dio dio = new Dio();
    dio.options.baseUrl = serviceUrl;
    FormData formData =
        new FormData.from({'file': UploadFileInfo(img, basename(img.path))});

    response = await dio.post('/file/do_upload', data: formData);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常。');
    }
  } catch (e) {
    print('ERROR:===========>$e');
    return {
      'success': false,
      'message': '${e.toString()}',
    };
  }
}
