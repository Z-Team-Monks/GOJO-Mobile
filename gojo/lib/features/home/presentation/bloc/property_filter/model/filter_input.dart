import 'package:flutter/material.dart';
import 'package:gojo/features/home/presentation/screen/widgets/filter_form_content.dart';

@immutable
class FilterInput {
  final List<String> categories;
  final List<String> selectedCategories;

  final List<String> facilities;
  final List<String> selectedFacilities;

  final double minimumPriceRange;
  final double maximumPriceRange;

  final String? location;
  final List<String> selectedRating;

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
    List<String>? categories,
    List<String>? selectedCategories,
    List<String>? facilities,
    List<String>? selectedFacilities,
    double? minimumPriceRange,
    double? maximumPriceRange,
    String? location,
    List<String>? selectedRating,
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
      selectedRating: [],
    );
  }
}
