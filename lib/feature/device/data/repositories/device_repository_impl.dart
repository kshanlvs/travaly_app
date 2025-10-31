import 'package:travaly_app/core/network/network_client.dart';
import 'package:travaly_app/feature/device/domain/repositories/device_repository.dart';

class DeviceRepositoryImpl implements DeviceRegistrationService {
  final NetworkClient _networkClient;

  DeviceRepositoryImpl(this._networkClient);

  @override
  Future<String> registerDevice(Map<String, dynamic> deviceData) async {
    try {
      final response = await _networkClient.post(
        '/public/v1/',
        data: {
          "action": "deviceRegister",
          "deviceRegister": deviceData,
        },
        headers: {
          'authtoken': '71523fdd8d26f585315b4233e39d9263',
        },
      );

    
      final bool status = response['status'] == true;
      final String? message = response['message'];
      final String? visitorToken = response['data']?['visitorToken'];

      if (status && visitorToken != null && visitorToken.isNotEmpty) {
        // Successful registration — return the token
        return visitorToken;
      }

      // ✅ Handle success messages that may not strictly use 'status'
      if (message?.toLowerCase().contains('device registered successfully') ??
          false) {
        return visitorToken ?? '';
      }

      throw DeviceRegistrationException(
        'Device registration failed: ${message ?? "Unknown error"}',
      );
    } catch (e) {
      throw DeviceRegistrationException('Failed to register device: $e');
    }
  }
}

class DeviceRegistrationException implements Exception {
  final String message;
  DeviceRegistrationException(this.message);

  @override
  String toString() => 'DeviceRegistrationException: $message';
}
