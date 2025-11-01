import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travaly_app/core/constants/app_constants.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/hotel_bloc.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/hotel_event.dart';
import 'package:travaly_app/feature/hotel/presentation/widgets/category_button.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  String selectedCategory = AppText.hotel;

  final List<String> categories = [
    AppText.hotel,
    AppText.resorts,
    AppText.homeStay,
    AppText.campAndSites,
    AppText.any,
  ];

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
              final label = categories[index];
              return CategoryButton(
                label: label,
                isSelected: selectedCategory == label,
                onPressed: () {
                  setState(() {
                    selectedCategory = label;
                  });

                  context.read<HotelBloc>().add(
                        LoadPopularHotelsEvent(
                          entityType: label,
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
