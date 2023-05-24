part of 'create_property_bloc.dart';

@immutable
abstract class CreatePropertyEvent {}

class OnTitleInputChanged extends CreatePropertyEvent {
  final TitleInput titleInput;
  OnTitleInputChanged(this.titleInput);
}

class OnDescriptionInputChanged extends CreatePropertyEvent {
  final String descriptionInput;
  OnDescriptionInputChanged(this.descriptionInput);
}

class OnNumberOfBedRoomsInputChanged extends CreatePropertyEvent {
  final NumberOfBedRoomsInput numberOfBedRoomsInput;
  OnNumberOfBedRoomsInputChanged(this.numberOfBedRoomsInput);
}

class OnNumberOfBathroomsInputChanged extends CreatePropertyEvent {
  final NumberOfBathroomsInput numberOfBathroomsInput;
  OnNumberOfBathroomsInputChanged(this.numberOfBathroomsInput);
}

class OnSqaureAreaInputChanged extends CreatePropertyEvent {
  final SqaureAreaInput sqaureAreaInput;
  OnSqaureAreaInputChanged(this.sqaureAreaInput);
}

class OnCategorySelected extends CreatePropertyEvent {
  final String selectedCategory;
  OnCategorySelected(this.selectedCategory);
}

class OnFacilitySelected extends CreatePropertyEvent {
  final String selectedFacility;
  OnFacilitySelected(this.selectedFacility);
}

class OnSaveButtonPressed extends CreatePropertyEvent {}
