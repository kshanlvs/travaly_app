import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travaly_app/core/constants/app_constants.dart';
import 'package:travaly_app/feature/hotel/domain/enum/hotel_category.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/hotel_bloc.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/hotel_event.dart';
import 'package:travaly_app/feature/hotel/presentation/widgets/category_button.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  HotelCategory selectedCategory = HotelCategory.hotel;

  final List<HotelCategory> categories = [
    HotelCategory.hotel,
    HotelCategory.resort,
    HotelCategory.homeStay,
    HotelCategory.campSites,
    HotelCategory.any,
  ];

  String getCategoryLabel(HotelCategory category) {
    switch (category) {
      case HotelCategory.hotel:
        return 'Hotel';
      case HotelCategory.resort:
        return 'Resort';
      case HotelCategory.homeStay:
        return 'Home Stay';
      case HotelCategory.campSites:
        return 'Camp & Sites';
      case HotelCategory.any:
        return 'Any';
    }
  }

  String getEntityType(HotelCategory category) {
    switch (category) {
      case HotelCategory.hotel:
        return 'hotel';
      case HotelCategory.resort:
        return 'resort';
      case HotelCategory.homeStay:
        return 'Home Stay';
      case HotelCategory.campSites:
        return 'Camp_sites/tent';
      case HotelCategory.any:
        return 'Any';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppConstants.spacingXXL,
          right: AppConstants.spacingXXL,
          bottom: AppConstants.spacingM,
        ),
        child: SizedBox(
          height: AppConstants.buttonHeightS,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final label = getCategoryLabel(category);

              return CategoryButton(
                label: label,
                isSelected: selectedCategory == category,
                onPressed: () {
                  setState(() {
                    selectedCategory = category;
                  });

                  context.read<HotelBloc>().add(
                        LoadPopularHotelsEvent(
                          entityType: getEntityType(category),
                          searchTypeInfo: {
                            'country': 'India',
                            'state': 'Jharkhand',
                            'city': 'Jamshedpur',
                          },
                        ),
                      );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
