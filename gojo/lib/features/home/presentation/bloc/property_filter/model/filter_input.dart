import 'package:flutter/material.dart';
import 'package:gojo/features/home/presentation/screen/widgets/filter_form_content.dart';

import '../../../../data_layer/model/property_item.dart';

@immutable
class FilterInput {
  final List<Category> categories;
  final List<Category> selectedCategories;

  final List<Facility> facilities;
  final List<Facility> selectedFacilities;

  final double minimumPriceRange;
  final double maximumPriceRange;

  final String? location;
  final String selectedRating;

  const FilterInput({
    required this.categories,
    required this.facilities,
    required this.minimumPriceRange,
    required this.maximumPriceRange,
    required this.selectedCategories,
    required this.selectedFacilities,
    required this.selectedRating,
    this.location,
  });

  FilterInput copyWith({
    List<Category>? categories,
    List<Category>? selectedCategories,
    List<Facility>? facilities,
    List<Facility>? selectedFacilities,
    double? minimumPriceRange,
    double? maximumPriceRange,
    String? location,
    String? selectedRating,
  }) {
    return FilterInput(
      categories: categories ?? this.categories,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      facilities: facilities ?? this.facilities,
      selectedFacilities: selectedFacilities ?? this.selectedFacilities,
      minimumPriceRange: minimumPriceRange ?? this.minimumPriceRange,
      maximumPriceRange: maximumPriceRange ?? this.maximumPriceRange,
      location: location ?? this.location,
      selectedRating: selectedRating ?? this.selectedRating,
    );
  }

  static FilterInput initialState() {
    return const FilterInput(
      categories: [],
      selectedCategories: [],
      facilities: [],
      selectedFacilities: [],
      minimumPriceRange: FilterFormContent.minRangeValue,
      maximumPriceRange: FilterFormContent.maxRangeValue,
      selectedRating: "1",
    );
  }
}
