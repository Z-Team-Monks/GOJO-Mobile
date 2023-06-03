part of 'property_filter_bloc.dart';

@immutable
abstract class PropertyFilterEvent {}

class LoadPropertyFilter extends PropertyFilterEvent {}

class UpdatePropertyFilter extends PropertyFilterEvent {
  final FilterInput filterInput;

  UpdatePropertyFilter(this.filterInput);
}

class CategorySelected extends PropertyFilterEvent {
  final String category;

  CategorySelected(this.category);
}

class FacilitySelected extends PropertyFilterEvent {
  final String facility;

  FacilitySelected(this.facility);
}

class RatingChanged extends PropertyFilterEvent {
  final String rating;

  RatingChanged(this.rating);
}

class PriceRangeChanged extends PropertyFilterEvent {
  final double minimumPriceRange;
  final double maximumPriceRange;

  PriceRangeChanged(this.minimumPriceRange, this.maximumPriceRange);
}
