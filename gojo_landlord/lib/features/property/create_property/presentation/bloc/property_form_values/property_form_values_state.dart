part of 'property_form_values_bloc.dart';

enum PropertyFormValuesFetchState { loading, success, failure }

@immutable
class PropertyFormValuesState {
  final List<Category> categories;
  final List<Facility> facilities;
  final PropertyFormValuesFetchState fetchState;

  const PropertyFormValuesState({
    required this.categories,
    required this.facilities,
    required this.fetchState,
  });

  factory PropertyFormValuesState.initial() {
    return const PropertyFormValuesState(
      categories: [],
      facilities: [],
      fetchState: PropertyFormValuesFetchState.loading,
    );
  }

  PropertyFormValuesState copyWith({
    List<Category>? categories,
    List<Facility>? facilities,
    PropertyFormValuesFetchState? fetchState,
  }) {
    return PropertyFormValuesState(
      categories: categories ?? this.categories,
      facilities: facilities ?? this.facilities,
      fetchState: fetchState ?? this.fetchState,
    );
  }
}
