part of 'apply_for_rent_bloc.dart';

enum ApplicationStatus { editing, inprogress, success, error, done }

class ApplyForRentState extends Equatable {
  final DateTime? startDate;
  final int? months;
  final String? message;
  final ApplicationStatus status;

  const ApplyForRentState({
    this.startDate,
    this.months,
    this.message,
    this.status = ApplicationStatus.editing,
  });

  ApplyForRentState copyWith({
    DateTime? startDate,
    int? months,
    String? message,
    ApplicationStatus? status,
  }) {
    return ApplyForRentState(
      startDate: startDate ?? this.startDate,
      months: months ?? this.months,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [startDate, months, message, status];

  bool get isFormValid => months != null && startDate != null;
}
