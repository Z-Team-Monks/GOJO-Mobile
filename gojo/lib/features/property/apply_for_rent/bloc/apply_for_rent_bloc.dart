import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../detail/data/model/apply_for_rent_model.dart';
import '../../detail/data/repository/detail_repository.dart';

part 'apply_for_rent_event.dart';
part 'apply_for_rent_state.dart';

class ApplyForRentBloc extends Bloc<ApplyForRentEvent, ApplyForRentState> {
  final PropertyDetailRepository propertyDetailRepository;
  final int propertyId;
  ApplyForRentBloc({
    required this.propertyDetailRepository,
    required this.propertyId,
  }) : super(const ApplyForRentState()) {
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
          startDate: state.startDate!,
          months: int.parse(state.months!),
          message: state.message,
          propertyId: propertyId,
        );
        await propertyDetailRepository.applyForRent(applyForRentModel);
        emit(state.copyWith(status: ApplicationStatus.success));
      } on DioError catch (e) {
        debugPrint(e.response.toString());
        emit(state.copyWith(status: ApplicationStatus.error));
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(status: ApplicationStatus.error));
      }

      emit(state.copyWith(status: ApplicationStatus.done));
    });
  }
}
