part of 'create_property_bloc.dart';

enum CreatePropertyPostStatus { initial, success, failure }

class CreatePropertyState {
  final TitleInput titleInput;
  final String descriptionInput;
  final NumberOfBedRoomsInput numberOfBedRoomsInput;
  final NumberOfBathroomsInput numberOfBathroomsInput;
  final SquareAreaInput sqaureAreaInput;
  final String? selectedCategory;
  final Set<String> selectedFacilities;
  final DateTime? startDate;
  final DateTime? endDate;
  final AddressInput address;
  final CreatePropertyPostStatus postStatus;

  CreatePropertyState({
    required this.titleInput,
    required this.descriptionInput,
    required this.numberOfBedRoomsInput,
    required this.numberOfBathroomsInput,
    required this.sqaureAreaInput,
    required this.selectedCategory,
    required this.selectedFacilities,
    required this.startDate,
    required this.endDate,
    required this.address,
    required this.postStatus,
  });

  factory CreatePropertyState.initial() {
    return CreatePropertyState(
      titleInput: const TitleInput.pure(),
      descriptionInput: '',
      numberOfBedRoomsInput: const NumberOfBedRoomsInput.pure(),
      numberOfBathroomsInput: const NumberOfBathroomsInput.pure(),
      sqaureAreaInput: const SquareAreaInput.pure(),
      selectedCategory: null,
      selectedFacilities: {},
      startDate: null,
      endDate: null,
      postStatus: CreatePropertyPostStatus.initial,
      address: const AddressInput.pure(),
    );
  }

  CreatePropertyState copyWith({
    TitleInput? titleInput,
    String? descriptionInput,
    NumberOfBedRoomsInput? numberOfBedRoomsInput,
    NumberOfBathroomsInput? numberOfBathroomsInput,
    SquareAreaInput? sqaureAreaInput,
    String? selectedCategory,
    Set<String>? selectedFacilities,
    DateTime? startDate,
    DateTime? endDate,
    CreatePropertyPostStatus? postStatus,
    AddressInput? address,
  }) {
    return CreatePropertyState(
      titleInput: titleInput ?? this.titleInput,
      descriptionInput: descriptionInput ?? this.descriptionInput,
      numberOfBedRoomsInput:
          numberOfBedRoomsInput ?? this.numberOfBedRoomsInput,
      numberOfBathroomsInput:
          numberOfBathroomsInput ?? this.numberOfBathroomsInput,
      sqaureAreaInput: sqaureAreaInput ?? this.sqaureAreaInput,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedFacilities: selectedFacilities ?? this.selectedFacilities,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      postStatus: postStatus ?? this.postStatus,
      address: address ?? this.address,
    );
  }
}
