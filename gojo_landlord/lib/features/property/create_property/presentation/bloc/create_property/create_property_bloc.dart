import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo_landlord/features/property/create_property/data_layer/model/address.dart';
import 'package:gojo_landlord/features/property/create_property/data_layer/model/category.dart';
import 'package:gojo_landlord/features/property/create_property/data_layer/model/new_property.dart';
import 'package:gojo_landlord/features/property/create_property/presentation/model/address_input.dart';

import '../../../data_layer/model/facility.dart';
import '../../../data_layer/property_repository.dart';
import '../../model/number_of_bathrooms.dart';
import '../../model/number_of_bedrooms_input.dart';
import '../../model/square_area_input.dart';
import '../../model/title_input.dart';

part 'create_property_event.dart';
part 'create_property_state.dart';

class CreatePropertyBloc
    extends Bloc<CreatePropertyEvent, CreatePropertyState> {
  final PropertyRepositoryAPI propertyRepository;
  final List<Category> fetchedCategories;
  final List<Facility> fetchedFacilities;

  CreatePropertyBloc({
    required this.propertyRepository,
    required this.fetchedCategories,
    required this.fetchedFacilities,
  }) : super(CreatePropertyState.initial()) {
    on<TitleInputChanged>((event, emit) {
      final titleInput = TitleInput.dirty(value: event.titleInput);
      emit(state.copyWith(titleInput: titleInput));
    });
    on<DescriptionInputChanged>((event, emit) {
      emit(state.copyWith(descriptionInput: event.descriptionInput));
    });
    on<NumberOfBedRoomsInputChanged>((event, emit) {
      final numberOfBedRoomsInput = NumberOfBedRoomsInput.dirty(
        value: event.numberOfBedRoomsInput,
      );
      emit(state.copyWith(numberOfBedRoomsInput: numberOfBedRoomsInput));
    });
    on<NumberOfBathRoomsInputChanged>((event, emit) {
      final numberOfBathroomsInput = NumberOfBathroomsInput.dirty(
        value: event.numberOfBathroomsInput,
      );
      emit(state.copyWith(numberOfBathroomsInput: numberOfBathroomsInput));
    });
    on<SqaureAreaInputChanged>((event, emit) {
      final squareAreaInput = SquareAreaInput.dirty(
        value: event.squareAreaInput,
      );
      emit(state.copyWith(sqaureAreaInput: squareAreaInput));
    });
    on<CategorySelected>((event, emit) {
      emit(state.copyWith(selectedCategory: event.selectedCategory));
    });
    on<FacilitySelected>((event, emit) {
      final selectedFacility = event.selectedFacility;
      if (state.selectedFacilities.contains(selectedFacility)) {
        state.selectedFacilities.remove(selectedFacility);
      } else {
        state.selectedFacilities.add(selectedFacility);
      }
      emit(state);
    });

    on<StartDateSelected>((event, emit) {
      emit(state.copyWith(startDate: event.startDate));
    });
    on<EndDateSelected>((event, emit) {
      emit(state.copyWith(endDate: event.endDate));
    });

    on<AddressSelected>((event, emit) {
      final address = AddressInput.dirty(value: event.address);
      emit(state.copyWith(address: address));
    });

    on<SaveButtonPressed>((event, emit) {
      final numberOfBedrooms = _getFacility("Number of Bed rooms")
          .copyWith(amount: int.tryParse(state.numberOfBedRoomsInput.value));

      final numberOfBathrooms = _getFacility("Number of Bath rooms")
          .copyWith(amount: int.tryParse(state.numberOfBathroomsInput.value));

      final squareArea = _getFacility("Square area")
          .copyWith(amount: int.tryParse(state.sqaureAreaInput.value));

      final facilities = [
        numberOfBedrooms,
        numberOfBathrooms,
        squareArea,
        ...state.selectedFacilities
            .map((facilityName) => _getFacility(facilityName))
            .toList(),
      ];

      final category = _getCategory(state.selectedCategory!);

      final newProperty = NewProperty(
        startDate: state.startDate!,
        endDate: state.endDate!,
        facilities: facilities,
        category: category,
        address: state.address.value!,
      );

      try {
        propertyRepository.createProperty(newProperty);
        emit(state.copyWith(postStatus: CreatePropertyPostStatus.success));
        emit(CreatePropertyState.initial());
      } catch (e) {
        emit(state.copyWith(postStatus: CreatePropertyPostStatus.failure));
      }
    });
  }

  Category _getCategory(String categoryName) {
    return fetchedCategories
        .firstWhere((category) => category.name == categoryName);
  }

  Facility _getFacility(String facilityName) {
    debugPrint(facilityName);
    return fetchedFacilities
        .firstWhere((facility) => facility.name == facilityName);
  }
}
