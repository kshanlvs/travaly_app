part of 'device_bloc.dart';

abstract class DeviceState {}

class DeviceInitial extends DeviceState {}
class DeviceLoading extends DeviceState {}

class DeviceRegisteredSuccess extends DeviceState {
  final String visitorToken;
  DeviceRegisteredSuccess(this.visitorToken);
}

class DeviceRegistrationFailed extends DeviceState {
  final String error;
  DeviceRegistrationFailed(this.error);
}
class DeviceNotRegistered extends DeviceState {}
