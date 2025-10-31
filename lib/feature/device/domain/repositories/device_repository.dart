abstract class DeviceRegistrationService {
  Future<String> registerDevice(Map<String, dynamic> deviceData);
}

abstract class DeviceStatusService {
  Future<bool> isDeviceRegistered();
}

abstract class DeviceStorageService {
  Future<void> saveDeviceRegistrationStatus(bool isRegistered);
}
class DeviceRegistrationException implements Exception {
  final String message;
  DeviceRegistrationException(this.message);
  
  @override
  String toString() => 'DeviceRegistrationException: $message';
}