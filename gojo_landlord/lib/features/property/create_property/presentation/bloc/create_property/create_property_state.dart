part of 'create_property_bloc.dart';

enum CreatePropertyPostStatus { initial, success, failure }

class CreatePropertyState {
  final TitleInput titleInput;
  final DescriptionInput descriptionInput;
  final RentInput rentInput;
  final NumberOfBedRoomsInput numberOfBedRoomsInput;
  final NumberOfBathroomsInput numberOfBathroomsInput;
  final SquareAreaInput sqaureAreaInput;
  final String? selectedCategory;
  final Set<String> selectedFacilities;
  final DateTime? startDate;
  final DateTime? endDate;
  final AddressInput address;
  final WeeklyVisitingHours weeklyVisitingHours;
  final CreatePropertyPostStatus postStatus;

  CreatePropertyState({
    required this.titleInput,
    required this.descriptionInput,
    required this.rentInput,
    required this.numberOfBedRoomsInput,
    required this.numberOfBathroomsInput,
    required this.sqaureAreaInput,
    required this.selectedCategory,
    required this.selectedFacilities,
    required this.startDate,
    required this.endDate,
    required this.address,
    required this.weeklyVisitingHours,
    required this.postStatus,
  });

  factory CreatePropertyState.initial() {
    return CreatePropertyState(
      titleInput: const TitleInput.pure(),
      descriptionInput: const DescriptionInput.pure(),
      rentInput: const RentInput.pure(),
      numberOfBedRoomsInput: const NumberOfBedRoomsInput.pure(),
      numberOfBathroomsInput: const NumberOfBathroomsInput.pure(),
      sqaureAreaInput: const SquareAreaInput.pure(),
      selectedCategory: null,
      selectedFacilities: {},
      startDate: null,
      endDate: null,
      address: const AddressInput.pure(),
      weeklyVisitingHours: WeeklyVisitingHours(),
      postStatus: CreatePropertyPostStatus.initial,
    );
  }

  CreatePropertyState copyWith({
    TitleInput? titleInput,
    DescriptionInput? descriptionInput,
    RentInput? rentInput,
    NumberOfBedRoomsInput? numberOfBedRoomsInput,
    NumberOfBathroomsInput? numberOfBathroomsInput,
    SquareAreaInput? sqaureAreaInput,
    String? selectedCategory,
    Set<String>? selectedFacilities,
    DateTime? startDate,
    DateTime? endDate,
    AddressInput? address,
    WeeklyVisitingHours? weeklyVisitingHours,
    CreatePropertyPostStatus? postStatus,
  }) {
    return CreatePropertyState(
      titleInput: titleInput ?? this.titleInput,
      descriptionInput: descriptionInput ?? this.descriptionInput,
      rentInput: rentInput ?? this.rentInput,
      numberOfBedRoomsInput:
          numberOfBedRoomsInput ?? this.numberOfBedRoomsInput,
      numberOfBathroomsInput:
          numberOfBathroomsInput ?? this.numberOfBathroomsInput,
      sqaureAreaInput: sqaureAreaInput ?? this.sqaureAreaInput,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedFacilities: selectedFacilities ?? this.selectedFacilities,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      address: address ?? this.address,
      weeklyVisitingHours: weeklyVisitingHours ?? this.weeklyVisitingHours,
      postStatus: postStatus ?? this.postStatus,
    );
  }
}
