import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      if (Platform.isAndroid) {
        return await _getAndroidDeviceInfo();
      } else if (Platform.isIOS) {
        return await _getIOSDeviceInfo();
      }
      return _getFallbackDeviceInfo();
    } catch (e) {
      return _getFallbackDeviceInfo();
    }
  }

  Future<Map<String, dynamic>> _getAndroidDeviceInfo() async {
    final androidInfo = await _deviceInfo.androidInfo;

    return {
      "deviceModel": androidInfo.model,
      "deviceFingerprint": androidInfo.fingerprint,
      "deviceBrand": androidInfo.brand,
      "deviceId": androidInfo.id,
      "deviceName": androidInfo.device,
      "deviceManufacturer": androidInfo.manufacturer,
      "deviceProduct": androidInfo.product,
      "deviceSerialNumber": androidInfo.serialNumber.isEmpty
          ? 'unknown'
          : androidInfo.serialNumber,
    };
  }

  Future<Map<String, dynamic>> _getIOSDeviceInfo() async {
    final iosInfo = await _deviceInfo.iosInfo;

    return {
      "deviceModel": iosInfo.model,
      "deviceFingerprint": iosInfo.identifierForVendor ?? 'unknown',
      "deviceBrand": 'Apple',
      "deviceId": iosInfo.identifierForVendor ?? 'unknown',
      "deviceName": iosInfo.name,
      "deviceManufacturer": 'Apple',
      "deviceProduct": iosInfo.model,
      "deviceSerialNumber": iosInfo.identifierForVendor ?? 'unknown',
    };
  }

  Map<String, dynamic> _getFallbackDeviceInfo() {
    return {
      "deviceModel": 'unknown',
      "deviceFingerprint": 'unknown',
      "deviceBrand": 'unknown',
      "deviceId": 'unknown',
      "deviceName": 'unknown',
      "deviceManufacturer": 'unknown',
      "deviceProduct": 'unknown',
      "deviceSerialNumber": 'unknown',
    };
  }
}
