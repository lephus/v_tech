import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import '../../main.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'package:v_tech_tmdt/constants/constants.dart';

String? getTime(String value) {
  final f = new DateFormat('yyyy-MM-ddTHH:mm:ss').parse(value);
  String formattedDate = DateFormat('HH:mm').format(f);
  return formattedDate;
}

String? getTimeWithText(String value) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime.now().subtract(Duration(days: 1));
  final f = new DateFormat('yyyy-MM-ddTHH:mm:ss').parse(value);
  if (f == today) {
    return 'Hôm nay, ' + DateFormat('HH:mm').format(f);
  } else if (f == yesterday) {
    return 'Hôm qua, ' + DateFormat('HH:mm').format(f);
  } else {
    return DateFormat('dd/MM/yyyy').format(f);
  }
}

String? getDate(String value) {
    final f = new DateFormat('yyyy-MM-ddTHH:mm:ss').parse(value);
    String formattedDate = DateFormat('dd/MM/yyyy').format(f);
    return formattedDate;
}

String getDateFilter(DateTime date) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);
    return formattedDate;
}

String? ymd(String value) {
    final f = DateFormat('dd-MM-yyyy').parse(value);
    String formattedDate = DateFormat('yyyy-MM-dd').format(f);
    return formattedDate;
}

String getCurrentDate() {
  final now = DateTime.now();
  return DateFormat('yyyy-MM-dd').format(now);
}


String? convertDateOriginal(String value) {
    final f = new DateFormat('dd/MM/yyy').parse(value);
    String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(f);
    return formattedDate;
}
DateTime? getDateTime(String value) {
  if (value != null) {
    final f = new DateFormat('yyyy-MM-dd').parse(value);
    return f;
  }
  return null;
}

String? getDateWithText(String value) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
    final f = new DateFormat('yyyy-MM-ddTHH:mm:ss').parse(value);
    if (f == today) {
      return 'Hôm nay';
    } else if (f == yesterday) {
      return 'Hôm qua';
    } else {
      return DateFormat('dd/MM/yyy').format(f);
    }
}

enum DatePatterns { ymd, fullT }
String? handleCreatedDateTime(BuildContext context, String time) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final f = DateTime.parse(time);
  final targetDate = DateTime(f.year, f.month, f.day);
  if (targetDate == today) {
    return "Hôm nay, " + hhmm(f)!;
  } else if (targetDate == yesterday) {
    return "Hôm qua, " + hhmm(f)!;
  } else {
    return yMd(f);
  }
}

// Format date display
String? handleCreatedDate(BuildContext context, String time) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final f = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(time);
  final targetDate = DateTime(f.year, f.month, f.day);
  if (targetDate == today) {
    return "Hôm nay";
  } else if (targetDate == yesterday) {
    return "Hôm qua";
  } else {
    return yMd(f);
  }
}

DateTime formatFromTimeStamp(timeStamp) {
  return DateTime.fromMillisecondsSinceEpoch(timeStamp);
}

String? hhmm(DateTime date) {
    String formattedDate = DateFormat('HH:mm').format(date);
    return formattedDate;
}

String? yMd(DateTime date) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);
    return formattedDate;
}

String convertMoney(double money) {
  if (money.toString() == '') return '0 VND';
  final formatCurrency =
  new NumberFormat.currency(decimalDigits: 0, symbol: '');
  String form = formatCurrency.format(money.toInt()).toString();
  return '$form VND';
}

String convertMoneyNDT(double money) {
  if (money.toString() == '') return '0 NDT';
  final formatCurrency =
  new NumberFormat.currency(decimalDigits: 0, symbol: '');
  String form = formatCurrency.format(money.toInt()).toString();
  return '$form NDT';
}

String convertMoneyString(double money) {
  var a;
  var b;
  var formatMoney = convertMoney(money);
  var fm = formatMoney.replaceAll(' VND', '');
  int count = fm.split(',').length - 1;
  if (count == 0 || count == 1) {
    return convertMoney(money);
  } else if (count == 2) {
    a = int.tryParse(fm.replaceAll(',', ''));
    b = a / 1000000;
    b = getNumber(b);
    return '$b triệu';
  } else if (count >= 3) {
    a = int.tryParse(fm.replaceAll(',', ''));
    b = a / 1000000000;
    b = getNumber(b);
    if (b >= 1000) {
      final formatCurrency =
      new NumberFormat.currency(decimalDigits: 2, symbol: '');
      // new NumberFormat('#,###.0#', 'en_US');
      String form = formatCurrency.format(b).toString();
      return '$form tỷ';
    } else {
      return '$b tỷ';
    }
  } else {
    return '0 VND';
  }
}

double getNumber(double input, {int precision = 2}) {
  var finalVal = 0.0;
  int length =
      '$input'.substring('$input'.indexOf('.') + 1, '$input'.length).length;
  int offSet = length > 1 ? 1 : 0;
  finalVal = double.parse(
      '$input'.substring(0, '$input'.indexOf('.') + precision + offSet));
  return finalVal;
}


String ConvertMillisecondsToHourMinute(int milliseconds ){
  DateTime date = new DateTime.fromMillisecondsSinceEpoch(milliseconds);
  return "${date.hour} - ${date.minute}";
}

// Future<void> makePhoneCall(String url) async {
//   if (await canLaunch('tel:$url')) {
//     await launch('tel:$url');
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// Future<void> makePhoneSms(String url) async {
//   if (await canLaunch('sms:$url')) {
//     await launch('sms:$url');
//   } else {
//     throw 'Could not launch $url';
//   }
// }
