part of 'property_items_bloc.dart';

@immutable
abstract class PropertyItemsEvent {}

class LoadPropertyItems extends PropertyItemsEvent {
  final FilterInput filterInput;
  final String searchQuery;

  LoadPropertyItems({required this.searchQuery, required this.filterInput});
}

class UpdateFilterInputs extends PropertyItemsEvent {
  final FilterInput filterInput;

  UpdateFilterInputs(this.filterInput);
}
