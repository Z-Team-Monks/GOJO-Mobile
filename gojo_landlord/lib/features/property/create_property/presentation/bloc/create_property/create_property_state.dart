part of 'create_property_bloc.dart';

class CreatePropertyState {
  final TitleInput titleInput;
  final String descriptionInput;
  final NumberOfBedRoomsInput numberOfBedRoomsInput;
  final NumberOfBathroomsInput numberOfBathroomsInput;
  final SqaureAreaInput sqaureAreaInput;
  final String selectedCategory;
  final List<String> selectedFacilities;

  CreatePropertyState({
    required this.titleInput,
    required this.descriptionInput,
    required this.numberOfBedRoomsInput,
    required this.numberOfBathroomsInput,
    required this.sqaureAreaInput,
    required this.selectedCategory,
    required this.selectedFacilities,
  });

  factory CreatePropertyState.initial() {
    return CreatePropertyState(
      titleInput: const TitleInput.pure(),
      descriptionInput: '',
      numberOfBedRoomsInput: const NumberOfBedRoomsInput.pure(),
      numberOfBathroomsInput: const NumberOfBathroomsInput.pure(),
      sqaureAreaInput: const SqaureAreaInput.pure(),
      selectedCategory: '',
      selectedFacilities: [],
    );
  }

  CreatePropertyState copyWith({
    TitleInput? titleInput,
    String? descriptionInput,
    NumberOfBedRoomsInput? numberOfBedRoomsInput,
    NumberOfBathroomsInput? numberOfBathroomsInput,
    SqaureAreaInput? sqaureAreaInput,
    String? selectedCategory,
    List<String>? selectedFacilities,
  }) {
    return CreatePropertyState(
      titleInput: titleInput ?? this.titleInput,
      descriptionInput: descriptionInput ?? this.descriptionInput,
      numberOfBedRoomsInput: numberOfBedRoomsInput ?? this.numberOfBedRoomsInput,
      numberOfBathroomsInput: numberOfBathroomsInput ?? this.numberOfBathroomsInput,
      sqaureAreaInput: sqaureAreaInput ?? this.sqaureAreaInput,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedFacilities: selectedFacilities ?? this.selectedFacilities,
    );
  }
}
