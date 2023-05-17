import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:travellers/domain/entities/device_info.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  
  try {
    if(Platform.isAndroid) {
      //return 
      var build = await deviceInfoPlugin.androidInfo;
      name = build.brand+" "+build.model;
      identifier = build.version.codename;
      version = build.version.codename;
    }
    else if(Platform.isIOS) {
      //return 
      var build = await deviceInfoPlugin.iosInfo;
      name = build.name+" "+build.model;
      identifier = build.identifierForVendor;
      version = build.identifierForVendor;
    }
  } on PlatformException {
    return DeviceInfo(name, identifier, version);
  }
  return DeviceInfo(name, identifier, version);

}