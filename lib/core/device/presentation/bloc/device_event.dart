
part of 'device_bloc.dart';
abstract class DeviceEvent {}



class CheckDeviceRegistrationEvent extends DeviceEvent {}

class RegisterDeviceEvent extends DeviceEvent {
  final Map<String, dynamic>? deviceData;
  RegisterDeviceEvent({this.deviceData});
}
