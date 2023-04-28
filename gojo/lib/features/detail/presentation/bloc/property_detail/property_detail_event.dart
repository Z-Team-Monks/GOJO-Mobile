part of 'property_detail_bloc.dart';

abstract class PropertyDetailEvent extends Equatable {}

class LoadPropertyDetail extends PropertyDetailEvent {
  final String propertyId;

  LoadPropertyDetail({required this.propertyId});

  @override
  List<Object?> get props => [propertyId];
}
