import 'package:get_it/get_it.dart';
import 'package:travaly_app/core/network/network_client.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_repositories.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_repository_impl.dart';

final GetIt slHotel = GetIt.instance;

void initHotelServiceLocator() {
  slHotel.registerLazySingleton<HotelRepository>(() => HotelRepositoryImpl(
        dio: slHotel<NetworkClient>(),
      ));
  slHotel.registerLazySingleton<HotelRepository>(() => HotelRepositoryImpl(
        dio: slHotel<NetworkClient>(),
      ));
}
