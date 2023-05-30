import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo_landlord/features/property/create_property/data_layer/model/address.dart';
import 'package:gojo_landlord/features/property/create_property/data_layer/model/category.dart';
import 'package:gojo_landlord/features/property/create_property/data_layer/model/new_property.dart';
import 'package:gojo_landlord/features/property/create_property/presentation/model/address_input.dart';
import 'package:gojo_landlord/features/property/create_property/presentation/model/description_input.dart';

import '../../../../../../Gojo-Mobile-Shared/constants/facilities.dart';
import '../../../data_layer/model/facility.dart';
import '../../../data_layer/model/visiting_hour.dart';
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
      final descriptionInput =
          DescriptionInput.dirty(value: event.descriptionInput);
      emit(state.copyWith(descriptionInput: descriptionInput));
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
      final newFacility = event.selectedFacility;
      final selectedFacilities = state.selectedFacilities;
      if (selectedFacilities.contains(newFacility)) {
        selectedFacilities.remove(newFacility);
      } else {
        selectedFacilities.add(newFacility);
      }
      emit(state.copyWith(selectedFacilities: selectedFacilities));
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

    on<VisitingHourAdded>((event, emit) {
      final visitingHours = state.weeklyVisitingHours;
      visitingHours.addVisitingHour(event.visitingHour);
      emit(state.copyWith(weeklyVisitingHours: visitingHours));
    });

    on<VisitingHourRemoved>((event, emit) {
      final visitingHours = state.weeklyVisitingHours;
      visitingHours.removeVisitingHour(event.day);
      emit(state.copyWith(weeklyVisitingHours: visitingHours));
    });

    on<SaveButtonPressed>((event, emit) async {
      final numberOfBedrooms = _getFacility(GojoFacilities.numberOfBedRooms)
          .copyWith(amount: double.tryParse(state.numberOfBedRoomsInput.value));

      final numberOfBathrooms = _getFacility(GojoFacilities.numberOfBathRooms)
          .copyWith(
              amount: double.tryParse(state.numberOfBathroomsInput.value));

      final squareArea = _getFacility(GojoFacilities.squareArea)
          .copyWith(amount: double.tryParse(state.sqaureAreaInput.value));

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
        title: state.titleInput.value,
        description: state.descriptionInput.value,
        startDate: state.startDate!,
        facilities: facilities,
        category: category,
        address: state.address.value!,
        weeklyVisitingHour: state.weeklyVisitingHours,
      );

      try {
        // await propertyRepository.createProperty(newProperty);
        emit(state.copyWith(postStatus: CreatePropertyPostStatus.success));
        emit(CreatePropertyState.initial());
      } catch (e) {
        emit(state.copyWith(postStatus: CreatePropertyPostStatus.failure));
      }
    });
  }

  static List<Facility> getSelectableFacilites(List<Facility> facilities) {
    final facilitiesNotToInclude = [
      GojoFacilities.numberOfBathRooms,
      GojoFacilities.numberOfBedRooms,
      GojoFacilities.squareArea,
    ];

    return facilities
        .where((element) => !facilitiesNotToInclude.contains(element.name))
        .toList();
  }

  Category _getCategory(String categoryName) {
    try {
      return fetchedCategories
          .firstWhere((category) => category.name == categoryName);
    } catch (e) {
      throw Exception("Category not found");
    }
  }

  Facility _getFacility(String facilityName) {
    debugPrint(facilityName);

    debugPrint(fetchedFacilities.toList().toString());
    try {
      return fetchedFacilities
          .firstWhere((facility) => facility.name == facilityName);
    } catch (e) {
      throw Exception("Facility not found");
    }
  }
}
