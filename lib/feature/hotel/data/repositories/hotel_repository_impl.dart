import 'package:travaly_app/core/network/network_client.dart';
import 'package:travaly_app/feature/hotel/data/models/hotel_model.dart';
import 'package:travaly_app/feature/hotel/data/models/request/popular_stay_request.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_repositories.dart';

class HotelRepositoryImpl implements HotelRepository {
  final NetworkClient dio;

  HotelRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<HotelData>> getPopularHotels({
    required int limit,
    required String entityType,
    required String searchType,
    required Map<String, dynamic> searchTypeInfo,
    required String currency,
  }) async {
    try {
      // Create the request object
      final request = PopularStayRequest(
        action: 'popularStay',
        popularStay: PopularStay(
          limit: limit,
          entityType: entityType,
          filter: Filter(
            searchType: searchType,
            searchTypeInfo: SearchTypeInfo(
              country: searchTypeInfo['country'] ?? 'India',
              state: searchTypeInfo['state'] ?? '',
              city: searchTypeInfo['city'] ?? '',
            ),
          ),
          currency: currency,
        ),
      );

      print('🔵 Sending popularStay request');
      print('🔵 Request payload: ${request.toJson()}');

      // Make API call - NetworkClient should already have base URL
      final response = await dio.post(
        '/public/v1/', // Empty string if base URL is in NetworkClient
        data: request.toJson(),
        headers: {
          'authtoken': '71523fdd8d26f585315b4233e39d9263',
        },
      );

      // Parse response using the main HotelModel
      final hotelModel = HotelModel.fromJson(response);

      // Check if the API call was successful
      if (hotelModel.status == true) {
        final hotels = hotelModel.data ?? [];
        print('✅ Successfully loaded ${hotels.length} hotels');
        return hotels;
      } else {
        final errorMessage = hotelModel.message ?? 'Failed to load hotels';
        print('🔴 API Error: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('🔴 Repository Error: $e');
      throw Exception('Failed to load hotels: $e');
    }
  }
}
