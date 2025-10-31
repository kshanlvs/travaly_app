import 'package:travaly_app/feature/hotel/data/models/hotel_model.dart';

abstract class HotelRepository {
  Future<List<HotelData>> getPopularHotels({
    required int limit,
    required String entityType,
    required String searchType,
    required Map<String, dynamic> searchTypeInfo,
    required String currency,
  });
}
