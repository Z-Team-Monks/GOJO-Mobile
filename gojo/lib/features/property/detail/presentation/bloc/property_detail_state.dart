part of 'property_detail_bloc.dart';

enum FetchPropertyDetailStatus { loading, success, error }

class PropertyDetailState extends Equatable {
  final Property? property;
  final FetchPropertyDetailStatus status;

  const PropertyDetailState({
    this.property,
    this.status = FetchPropertyDetailStatus.loading,
  });

  PropertyDetailState copyWith({
    Property? property,
    FetchPropertyDetailStatus? status,
  }) {
    return PropertyDetailState(
      property: property ?? this.property,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [property, status];
}
