part of 'property_detail_bloc.dart';

abstract class PropertyDetailEvent extends Equatable {}

class LoadPropertyDetail extends PropertyDetailEvent {
  final int propertyId;

  LoadPropertyDetail({required this.propertyId});

  @override
  List<Object?> get props => [propertyId];
}

class ReviewsAdded extends PropertyDetailEvent {
  final Review review;

  ReviewsAdded({required this.review});

  @override
  List<Object?> get props => [review];
}
