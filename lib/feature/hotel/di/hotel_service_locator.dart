import 'package:get_it/get_it.dart';
import 'package:travaly_app/core/network/network_client.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_repositories.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_repository_impl.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_search_repository.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_search_repository_impl.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/autocomplete/autocomplete_bloc.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/search/search_bloc.dart';

final GetIt slHotel = GetIt.instance;

void initHotelServiceLocator() {
  slHotel.registerLazySingleton<HotelRepository>(() => HotelRepositoryImpl(
        dio: slHotel<NetworkClient>(),
      ));

  slHotel.registerLazySingleton<HotelSearchRepository>(
      () => HotelSearchRepositoryImpl(
            apiClient: slHotel<NetworkClient>(),
          ));
  slHotel.registerFactory<AutocompleteBloc>(() => AutocompleteBloc(
        hotelSearchRepository: slHotel<HotelSearchRepository>(),
      ));
  slHotel.registerFactory<SearchBloc>(() => SearchBloc(
        hotelSearchRepository: slHotel<HotelSearchRepository>(),
      ));
}
