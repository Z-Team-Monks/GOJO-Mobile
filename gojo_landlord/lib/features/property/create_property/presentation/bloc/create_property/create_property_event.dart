part of 'create_property_bloc.dart';

@immutable
abstract class CreatePropertyEvent {}

class TitleInputChanged extends CreatePropertyEvent {
  final String titleInput;
  TitleInputChanged(this.titleInput);
}

class DescriptionInputChanged extends CreatePropertyEvent {
  final String descriptionInput;
  DescriptionInputChanged(this.descriptionInput);
}

class RentInputChanged extends CreatePropertyEvent {
  final String rent;
  RentInputChanged(this.rent);
}

class NumberOfBedRoomsInputChanged extends CreatePropertyEvent {
  final String numberOfBedRoomsInput;
  NumberOfBedRoomsInputChanged(this.numberOfBedRoomsInput);
}

class NumberOfBathRoomsInputChanged extends CreatePropertyEvent {
  final String numberOfBathroomsInput;
  NumberOfBathRoomsInputChanged(this.numberOfBathroomsInput);
}

class SqaureAreaInputChanged extends CreatePropertyEvent {
  final String squareAreaInput;
  SqaureAreaInputChanged(this.squareAreaInput);
}

class CategorySelected extends CreatePropertyEvent {
  final String selectedCategory;
  CategorySelected(this.selectedCategory);
}

class FacilitySelected extends CreatePropertyEvent {
  final String selectedFacility;
  FacilitySelected(this.selectedFacility);
}

class StartDateSelected extends CreatePropertyEvent {
  final DateTime startDate;
  StartDateSelected(this.startDate);
}

class EndDateSelected extends CreatePropertyEvent {
  final DateTime endDate;
  EndDateSelected(this.endDate);
}

class AddressSelected extends CreatePropertyEvent {
  final Address address;
  AddressSelected(this.address);
}

class VisitingHourAdded extends CreatePropertyEvent {
  final VisitingHour visitingHour;
  VisitingHourAdded(this.visitingHour);
}

class VisitingHourRemoved extends CreatePropertyEvent {
  final String day;
  VisitingHourRemoved(this.day);
}

class SaveButtonPressed extends CreatePropertyEvent {}
