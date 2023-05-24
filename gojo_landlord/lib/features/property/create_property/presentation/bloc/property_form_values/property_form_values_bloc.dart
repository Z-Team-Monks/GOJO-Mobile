import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../model/category.dart';
import '../../model/facility.dart';

part 'property_form_values_event.dart';
part 'property_form_values_state.dart';

class PropertyFormValuesBloc
    extends Bloc<PropertyFormValuesEvent, PropertyFormValuesState> {
  PropertyFormValuesBloc() : super(PropertyFormValuesState.initial()) {
    on<LoadPropertyFormValues>((event, emit) {});
  }
}
