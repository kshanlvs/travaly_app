import 'package:flutter/material.dart';
import 'package:travaly_app/feature/hotel/data/models/hotel_model.dart';

class HotelCard extends StatelessWidget {
  final HotelData hotel;

  const HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hotel Image
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              image: DecorationImage(
                image: NetworkImage(hotel.propertyImage ?? 'https://via.placeholder.com/150'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Star Rating
                if (hotel.propertyStar != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${hotel.propertyStar}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                
                // Google Review if available
                if (hotel.googleReview?.reviewPresent == true && hotel.googleReview?.data != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.thumb_up,
                            color: Colors.green,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${hotel.googleReview!.data!.overallRating?.toStringAsFixed(1)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Hotel Details
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location - City
                Text(
                  hotel.propertyAddress?.city ?? 'Unknown City',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                
                // Hotel Name
                Text(
                  hotel.propertyName ?? 'Unknown Property',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                // Address details if available
                if (hotel.propertyAddress?.street != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      hotel.propertyAddress!.street!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                
                const SizedBox(height: 8),
                
                // Features based on available policies and amenities
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _buildFeatureItems(),
                ),
                
                const SizedBox(height: 12),
                
                // Price and Favorite
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Price - using static price if available, otherwise marked price
                    if (hotel.staticPrice != null && hotel.staticPrice!.displayAmount != null)
                      Text(
                        '${hotel.staticPrice!.displayAmount!}/ Night',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C5364),
                        ),
                      )
                    else if (hotel.markedPrice != null && hotel.markedPrice!.displayAmount != null)
                      Text(
                        '${hotel.markedPrice!.displayAmount!}/ Night',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C5364),
                        ),
                      )
                    else
                      const Text(
                        '\$798/ Night',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C5364),
                        ),
                      ),
                    
                    // Favorite button
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C5364),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                
                // Additional info if available
                if (hotel.propertyPoliciesAndAmmenities?.data != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        if (hotel.propertyPoliciesAndAmmenities!.data!.freeWifi == true)
                          const Row(
                            children: [
                              Icon(Icons.wifi, size: 14, color: Colors.green),
                              SizedBox(width: 4),
                              Text(
                                'Free WiFi',
                                style: TextStyle(fontSize: 10, color: Colors.green),
                              ),
                            ],
                          ),
                        
                        if (hotel.propertyPoliciesAndAmmenities!.data!.freeCancellation == true)
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              children: [
                                const Icon(Icons.cancel, size: 14, color: Colors.orange),
                                const SizedBox(width: 4),
                                Text(
                                  'Free Cancel',
                                  style: TextStyle(fontSize: 10, color: Colors.orange[700]),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFeatureItems() {
    final List<Widget> features = [];
    
    // Add features based on available data
    if (hotel.propertyPoliciesAndAmmenities?.data != null) {
      final policies = hotel.propertyPoliciesAndAmmenities!.data!;
      
      if (policies.petsAllowed == true) {
        features.add(_buildFeatureItem('Pets Allowed'));
      }
      
      if (policies.coupleFriendly == true) {
        features.add(_buildFeatureItem('Couple Friendly'));
      }
      
      if (policies.suitableForChildren == true) {
        features.add(_buildFeatureItem('Family Friendly'));
      }
      
      if (policies.bachularsAllowed == true) {
        features.add(_buildFeatureItem('Bachelors OK'));
      }
    }
    
    // Add property type
    if (hotel.propertyType != null) {
      features.add(_buildFeatureItem(hotel.propertyType!));
    }
    
    // If no specific features, add some default ones
    if (features.isEmpty) {
      features.addAll([
        _buildFeatureItem('2 Beds'),
        _buildFeatureItem('2 Baths'),
        _buildFeatureItem('3 Guests'),
      ]);
    }
    
    return features;
  }

  Widget _buildFeatureItem(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}