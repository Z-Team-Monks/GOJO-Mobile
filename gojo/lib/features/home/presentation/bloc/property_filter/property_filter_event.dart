part of 'property_filter_bloc.dart';

@immutable
abstract class PropertyFilterEvent {}

class LoadPropertyFilter extends PropertyFilterEvent {}

class UpdatePropertyFilter extends PropertyFilterEvent {
  final FilterInput filterInput;

  UpdatePropertyFilter(this.filterInput);
}
