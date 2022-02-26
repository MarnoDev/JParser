import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///复制到粘贴板
void copyClipboard(BuildContext context, String? value) {
  final snackBar = SnackBar(content: Text('$value\n\n copy success to clipboard'));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  Clipboard.setData(ClipboardData(text: value ?? 'null'));
}

///拼接实际请求链接
String getRealUrl(String url, Map<String, dynamic> params) {
  final str = StringBuffer(url);
  if (params.isNotEmpty == true) {
    str.write('?');
    var hasAnd = false;
    params.forEach((key, value) {
      if (hasAnd) {
        hasAnd = true;
        str.write('&');
      }
      str.write('$key=$value');
    });
  }
  return str.toString();
}

///format(2018.09.08  11:22:333)
String getTimeStr(DateTime dateTime) {
  return '${twoNum(dateTime.year)}.${twoNum(dateTime.month)}.${twoNum(dateTime.day)}-'
      '${twoNum(dateTime.hour)}:${twoNum(dateTime.minute)}:${twoNum(dateTime.second)}:${dateTime.millisecond}';
}

///format(11:22:333)
String getTimeStr1(DateTime dateTime) {
  return '${twoNum(dateTime.hour)}:${twoNum(dateTime.minute)}:${twoNum(dateTime.second)}';
}

///转成两位数
String twoNum(int num) {
  return num > 9 ? num.toString() : '0$num';
}

///返回json格式的String
String toJson(data) {
  final je = const JsonEncoder.withIndent('  ');
  final json = je.convert(data);
  return json;
}

///返回json格式的String
String map2Json(Map? map) {
  if (map == null) {
    return '';
  }
  final sb = StringBuffer()..writeln('{');
  map.forEach((key, value) => sb.writeln('$key:$value'));
  sb.write('}');
  return sb.toString();
}
