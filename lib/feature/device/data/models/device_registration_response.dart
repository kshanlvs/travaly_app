class DeviceRegistrationResponse {
  final bool status;
  final String message;
  final int responseCode;
  final DeviceRegistrationData? data;

  DeviceRegistrationResponse({
    required this.status,
    required this.message,
    required this.responseCode,
    this.data,
  });

  factory DeviceRegistrationResponse.fromJson(Map<String, dynamic> json) {
    return DeviceRegistrationResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      responseCode: json['responseCode'] ?? 0,
      data: json['data'] != null
          ? DeviceRegistrationData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'responseCode': responseCode,
      'data': data?.toJson(),
    };
  }
}

class DeviceRegistrationData {
  final String visitorToken;

  DeviceRegistrationData({required this.visitorToken});

  factory DeviceRegistrationData.fromJson(Map<String, dynamic> json) {
    return DeviceRegistrationData(
      visitorToken: json['visitorToken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visitorToken': visitorToken,
    };
  }
}
