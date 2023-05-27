import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo_landlord/features/property/create_property/data_layer/property_repository.dart';
import 'package:meta/meta.dart';

import '../../../data_layer/model/category.dart';
import '../../../data_layer/model/facility.dart';

part 'property_form_values_event.dart';
part 'property_form_values_state.dart';

class PropertyFormValuesBloc
    extends Bloc<PropertyFormValuesEvent, PropertyFormValuesState> {
  final PropertyRepositoryAPI propertyRepository;
  PropertyFormValuesBloc(this.propertyRepository)
      : super(PropertyFormValuesState.initial()) {
    on<LoadPropertyFormValues>((event, emit) async {
      emit(state.copyWith(fetchState: PropertyFormValuesFetchState.loading));
      try {
        final facilities = await propertyRepository.getFacilities();
        final categories = await propertyRepository.getCategories();
        emit(state.copyWith(
            fetchState: PropertyFormValuesFetchState.success,
            facilities: facilities,
            categories: categories));
      } catch (e) {
        emit(state.copyWith(fetchState: PropertyFormValuesFetchState.failure));
      }
    });
  }
}
