part of 'property_items_bloc.dart';

enum FetchPropertyItemsStatus { loading, success, error }

@immutable
class PropertyItemsState {
  final FetchPropertyItemsStatus status;
  final String searchQuery;
  final List<PropertyItem> items;
  final FilterInput? filterInput;

  const PropertyItemsState({
    required this.status,
    required this.items,
    required this.searchQuery,
    required this.filterInput,
  });

  PropertyItemsState copyWith({
    FetchPropertyItemsStatus? status,
    String? searchQuery,
    List<PropertyItem>? items,
    FilterInput? filterInput,
  }) {
    return PropertyItemsState(
      status: status ?? this.status,
      searchQuery: searchQuery ?? this.searchQuery,
      items: items ?? this.items,
      filterInput: filterInput ?? this.filterInput,
    );
  }

  static PropertyItemsState initial() {
    return const PropertyItemsState(
      status: FetchPropertyItemsStatus.loading,
      items: [],
      searchQuery: "",
      filterInput: null,
    );
  }
}
