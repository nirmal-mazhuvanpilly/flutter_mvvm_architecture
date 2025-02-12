import 'dart:io';
import 'package:flutter/scheduler.dart';

Future<bool> isInternetAvailable() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
}

void afterInit(Function function) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    function.call();
  });
}
