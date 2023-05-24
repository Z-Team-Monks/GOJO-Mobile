import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gojo/features/property/detail/data/model/apply_for_rent_model.dart';
import 'package:gojo/features/property/detail/data/repository/detail_repository.dart';

part 'apply_for_rent_event.dart';
part 'apply_for_rent_state.dart';

class ApplyForRentBloc extends Bloc<ApplyForRentEvent, ApplyForRentState> {
  final PropertyDetailRepository propertyDetailRepository;
  final String propertyId;
  ApplyForRentBloc({
    required this.propertyDetailRepository,
    required this.propertyId,
  }) : super(ApplyForRentState(
          startDate: DateTime.now(),
        )) {
    on<MessageChanged>((event, emit) {
      emit(state.copyWith(message: event.message));
    });

    on<StartDateChanged>((event, emit) {
      emit(state.copyWith(startDate: event.startDate));
    });

    on<MonthsChanged>((event, emit) {
      emit(state.copyWith(months: event.months));
    });

    on<ApplicationSubmitted>((event, emit) async {
      emit(state.copyWith(status: ApplicationStatus.inprogress));
      try {
        final ApplyForRentModel applyForRentModel = ApplyForRentModel(
          startDate: state.startDate,
          months: state.months,
          message: state.message,
          propertyId: propertyId,
        );
        await propertyDetailRepository.applyForRent(applyForRentModel);
        emit(state.copyWith(status: ApplicationStatus.success));
      } catch (e) {
        emit(state.copyWith(status: ApplicationStatus.error));
      }

      emit(state.copyWith(status: ApplicationStatus.done));
    });
  }
}
