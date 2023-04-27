part of 'property_filter_bloc.dart';

enum FetchPropertyFilterStatus { loading, success, error }

@immutable
class PropertyFilterState {
  final FilterInput filterInput;
  final FetchPropertyFilterStatus status;

  const PropertyFilterState({
    required this.filterInput,
    required this.status,
  });

  PropertyFilterState copyWith({
    FilterInput? filterInput,
    FetchPropertyFilterStatus? status,
  }) {
    return PropertyFilterState(
      filterInput: filterInput ?? this.filterInput,
      status: status ?? this.status,
    );
  }

  static PropertyFilterState initialState() {
    return  PropertyFilterState(
      status: FetchPropertyFilterStatus.loading,
      filterInput: FilterInput.initialState(),
    );
  }
}
