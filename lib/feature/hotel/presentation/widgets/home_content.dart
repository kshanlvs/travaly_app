import 'package:flutter/material.dart';
import 'package:travaly_app/feature/hotel/presentation/widgets/header_section.dart';
import 'package:travaly_app/feature/hotel/presentation/widgets/search_section.dart';
import 'package:travaly_app/feature/hotel/presentation/widgets/category_selector.dart';
import 'package:travaly_app/feature/hotel/presentation/widgets/hotel_list_section.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        HeaderSection(),
        SearchSection(),
        CategorySelector(),
        HotelListSection(),
      ],
    );
  }
}
