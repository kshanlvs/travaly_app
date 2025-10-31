import 'package:bloc/bloc.dart';
import 'package:travaly_app/core/device/device_info_service.dart';
import 'package:travaly_app/core/storage/shared_preference_storage.dart';
import 'package:travaly_app/feature/device/domain/repositories/device_repository.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceRegistrationService _deviceService;
  final SharedPrefsStorage _localStorage;
  final DeviceInfoService _deviceInfoService;

  DeviceBloc(
    this._deviceService,
    this._localStorage,
    this._deviceInfoService,
  ) : super(DeviceInitial()) {
    on<CheckDeviceRegistrationEvent>(_onCheckDeviceRegistration);
    on<RegisterDeviceEvent>(_onRegisterDevice);
  }
  Future<void> _onCheckDeviceRegistration(
      CheckDeviceRegistrationEvent event, Emitter<DeviceState> emit) async {
    emit(DeviceLoading());
    final isRegistered =
        await _localStorage.getBool('device_registered') ?? false;
    final visitorsToken = await _localStorage.getString('visitors_token') ?? '';
    if (isRegistered) {
      emit(DeviceRegisteredSuccess(visitorsToken));
    } else {
      emit(DeviceNotRegistered());
    }
  }

  Future<void> _onRegisterDevice(
      RegisterDeviceEvent event, Emitter<DeviceState> emit) async {
    emit(DeviceLoading());
    try {
      final deviceInfo = await _deviceInfoService.getDeviceInfo();

      final result = await _deviceService.registerDevice(deviceInfo);
      if (result.isNotEmpty) {
        await _localStorage.setBool('device_registered', true);
        await _localStorage.setString('visitors_token', result);
        emit(DeviceRegisteredSuccess(result));
      } else {
        emit(DeviceRegistrationFailed('Device registration failed.'));
      }
    } catch (e) {
      emit(DeviceRegistrationFailed(e.toString()));
    }
  }
}
