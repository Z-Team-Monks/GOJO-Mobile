import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';

import '../../model/number_of_bathrooms.dart';
import '../../model/number_of_bedrooms_input.dart';
import '../../model/square_area_input.dart';
import '../../model/title_input.dart';

part 'create_property_event.dart';
part 'create_property_state.dart';

class CreatePropertyBloc
    extends Bloc<CreatePropertyEvent, CreatePropertyState> {
  CreatePropertyBloc() : super(CreatePropertyState.initial()) {
    on<OnTitleInputChanged>((event, emit) {
      emit(state.copyWith(titleInput: event.titleInput));
    });
    on<OnDescriptionInputChanged>((event, emit) {
      emit(state.copyWith(descriptionInput: event.descriptionInput));
    });
    on<OnNumberOfBedRoomsInputChanged>((event, emit) {
      emit(state.copyWith(numberOfBedRoomsInput: event.numberOfBedRoomsInput));
    });
    on<OnNumberOfBathroomsInputChanged>((event, emit) {
      emit(
          state.copyWith(numberOfBathroomsInput: event.numberOfBathroomsInput));
    });
    on<OnSqaureAreaInputChanged>((event, emit) {
      emit(state.copyWith(sqaureAreaInput: event.sqaureAreaInput));
    });
    on<OnCategorySelected>((event, emit) {
      emit(state.copyWith(selectedCategory: event.selectedCategory));
    });
    on<OnFacilitySelected>((event, emit) {
      emit(state.copyWith(selectedFacilities: [
        ...state.selectedFacilities,
        event.selectedFacility
      ]));
    });
    on<OnSaveButtonPressed>((event, emit) {});
  }
}
