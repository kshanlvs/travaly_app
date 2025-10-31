import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:travaly_app/feature/hotel/data/models/hotel_model.dart';
import 'package:travaly_app/core/constants/app_constants.dart';

class HotelCard extends StatelessWidget {
  final HotelData hotel;

  const HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.borderLight,
          width: AppConstants.borderWidthXS,
        ),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: AppConstants.imageHeightM,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppConstants.borderRadiusL),
                topRight: Radius.circular(AppConstants.borderRadiusL),
              ),
              child: _buildHotelImage(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.propertyAddress?.city ?? AppText.unknownCity,
                  style: const TextStyle(
                    fontSize: AppConstants.fontSizeL,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppConstants.spacingXS),
                Text(
                  hotel.propertyName ?? AppText.unknownProperty,
                  style: const TextStyle(
                    fontSize: AppConstants.fontSizeM,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (hotel.propertyAddress?.street != null)
                  Padding(
                    padding: const EdgeInsets.only(top: AppConstants.spacingXS),
                    child: Text(
                      hotel.propertyAddress!.street!,
                      style: const TextStyle(
                        fontSize: AppConstants.fontSizeS,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                const SizedBox(height: AppConstants.spacingM),
                Wrap(
                  spacing: AppConstants.spacingM,
                  runSpacing: AppConstants.spacingM,
                  children: _buildFeatureItems(),
                ),
                const SizedBox(height: AppConstants.spacingL),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPrice(),
                    _buildFavoriteButton(),
                  ],
                ),
                _buildPolicyIndicators(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelImage() {
    final imageUrl = hotel.propertyImage;

    if (imageUrl == null || imageUrl.isEmpty) {
      return _buildPlaceholderImage();
    }

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: AppConstants.imageHeightM,
          placeholder: (context, url) => _buildLoadingShimmer(),
          errorWidget: (context, url, error) => _buildPlaceholderImage(),
          fadeInDuration: AppConstants.durationM,
          fadeOutDuration: AppConstants.durationM,
        ),
        if (hotel.propertyStar != null)
          Positioned(
            top: AppConstants.spacingM,
            left: AppConstants.spacingM,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingM,
                vertical: AppConstants.spacingXS,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: AppConstants.iconSizeS,
                  ),
                  const SizedBox(width: AppConstants.spacingXS),
                  Text(
                    '${hotel.propertyStar}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: AppConstants.fontSizeS,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (hotel.googleReview?.reviewPresent == true &&
            hotel.googleReview?.data != null)
          Positioned(
            top: AppConstants.spacingM,
            right: AppConstants.spacingM,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingM,
                vertical: AppConstants.spacingXS,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.thumb_up,
                    color: Colors.green,
                    size: AppConstants.iconSizeXS,
                  ),
                  const SizedBox(width: AppConstants.spacingXS),
                  Text(
                    '${hotel.googleReview?.data?.overallRating?.toStringAsFixed(1)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: AppConstants.fontSizeS,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPrice() {
    final price = _getDisplayPrice();
    return Text(
      price,
      style: const TextStyle(
        fontSize: AppConstants.fontSizeL,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryColor,
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingL,
        vertical: AppConstants.spacingS,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusXL),
      ),
      child: const Icon(
        Icons.favorite_border,
        color: AppColors.white,
        size: AppConstants.iconSizeS,
      ),
    );
  }

  Widget _buildPolicyIndicators() {
    if (hotel.propertyPoliciesAndAmmenities?.data == null) {
      return const SizedBox.shrink();
    }

    final policies = hotel.propertyPoliciesAndAmmenities!.data!;
    final List<Widget> indicators = [];

    if (policies.freeWifi == true) {
      indicators.add(_buildPolicyIndicator(
        icon: Icons.wifi,
        text: AppText.freeWifi,
        color: AppColors.successColor,
      ));
    }

    if (policies.freeCancellation == true) {
      if (indicators.isNotEmpty) {
        indicators.add(const SizedBox(width: AppConstants.spacingL));
      }
      indicators.add(_buildPolicyIndicator(
        icon: Icons.cancel,
        text: AppText.freeCancel,
        color: AppColors.warningColor,
      ));
    }

    return indicators.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: AppConstants.spacingM),
            child: Row(children: indicators),
          )
        : const SizedBox.shrink();
  }

  Widget _buildPolicyIndicator({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, size: AppConstants.iconSizeS, color: color),
        const SizedBox(width: AppConstants.spacingXS),
        Text(
          text,
          style: TextStyle(
            fontSize: AppConstants.fontSizeXS,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingShimmer() {
    return Container(
      color: AppColors.gray300,
      child: const Center(
        child: SizedBox(
          width: AppConstants.iconSizeS,
          height: AppConstants.iconSizeS,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: AppColors.gray200,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo,
                color: AppColors.gray500, size: AppConstants.iconSizeXL),
            SizedBox(height: AppConstants.spacingXS),
            Text(
              AppText.noImage,
              style: TextStyle(
                color: AppColors.gray500,
                fontSize: AppConstants.fontSizeS,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFeatureItems() {
    final List<Widget> features = [];

    if (hotel.propertyPoliciesAndAmmenities?.data != null) {
      final policies = hotel.propertyPoliciesAndAmmenities!.data!;

      if (policies.petsAllowed == true) {
        features.add(_buildFeatureItem(AppText.petsAllowed));
      }

      if (policies.coupleFriendly == true) {
        features.add(_buildFeatureItem(AppText.coupleFriendly));
      }

      if (policies.suitableForChildren == true) {
        features.add(_buildFeatureItem(AppText.familyFriendly));
      }

      if (policies.bachularsAllowed == true) {
        features.add(_buildFeatureItem(AppText.bachelorsAllowed));
      }
    }

    if (hotel.propertyType != null) {
      features.add(_buildFeatureItem(hotel.propertyType!));
    }

    if (features.isEmpty) {
      features.addAll([
        _buildFeatureItem(AppText.defaultBeds),
        _buildFeatureItem(AppText.defaultBaths),
        _buildFeatureItem(AppText.defaultGuests),
      ]);
    }

    return features;
  }

  Widget _buildFeatureItem(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingM,
        vertical: AppConstants.spacingS,
      ),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: AppConstants.fontSizeXS,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  String _getDisplayPrice() {
    if (hotel.staticPrice != null && hotel.staticPrice!.displayAmount != null) {
      return '${hotel.staticPrice!.displayAmount!}${AppText.perNight}';
    } else if (hotel.markedPrice != null &&
        hotel.markedPrice!.displayAmount != null) {
      return '${hotel.markedPrice!.displayAmount!}${AppText.perNight}';
    } else {
      return '${AppText.defaultPrice}${AppText.perNight}';
    }
  }
}
