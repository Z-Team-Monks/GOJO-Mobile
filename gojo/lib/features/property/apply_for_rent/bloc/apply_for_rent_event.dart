part of 'apply_for_rent_bloc.dart';

abstract class ApplyForRentEvent extends Equatable {}

class StartDateChanged extends ApplyForRentEvent {
  final DateTime startDate;

  StartDateChanged({required this.startDate});

  @override
  List<Object?> get props => [startDate];
}

class MonthsChanged extends ApplyForRentEvent {
  final String months;

  MonthsChanged({required this.months});

  @override
  List<Object?> get props => [months];
}

class MessageChanged extends ApplyForRentEvent {
  final String message;

  MessageChanged({required this.message});

  @override
  List<Object?> get props => [message];
}

class ApplicationSubmitted extends ApplyForRentEvent {
  @override
  List<Object?> get props => [];
}
