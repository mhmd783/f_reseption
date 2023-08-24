import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

typedef Unit8ListCallback = Function(Uint8List data);

typedef DynamicCallback = Function(dynamic data);

final deviceinfo = DeviceInfoPlugin();

class clie {
  String hostName;
  int port;
  Unit8ListCallback onData;
  DynamicCallback onError;

  clie(
      {required this.hostName,
      required this.onData,
      required this.onError,
      required this.port});
  bool isConnected = false;
  Socket? socket;
  Future<void> connect() async {
    try {
      socket = await Socket.connect(hostName,port,timeout: Duration(seconds: 3));
      socket!.listen(onData, onError: onError, onDone: () async {
        // final info = await deviceinfo.androidInfo;
        // disconnect(info);
        isConnected = false;
      });
      isConnected = true;
    } catch (e) {
      isConnected = false;
      debugPrint("Error is $e");
    }
  }

  void write(String message) {
    socket!.write(message);
  }

  void disconnect(AndroidDeviceInfo androidDeviceInfo) {
    final message =
        '${androidDeviceInfo.brand} ${androidDeviceInfo.device} got disconnected';
    write(message);
    
    if (socket != null) {
      socket!.destroy();
    }
  }
}
