import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:gojo/features/home/data_layer/repository/home_repository.dart';
import 'package:gojo/features/home/presentation/bloc/property_filter/model/filter_input.dart';

part 'property_filter_event.dart';
part 'property_filter_state.dart';

class PropertyFilterBloc
    extends Bloc<PropertyFilterEvent, PropertyFilterState> {
  final HomeRepositoryAPI homeRepository;

  PropertyFilterBloc(this.homeRepository)
      : super(PropertyFilterState.initialState()) {
    on<LoadPropertyFilter>((event, emit) async {
      try {
        final categories = await homeRepository.getCategories();
        final facilities = await homeRepository.getFacilities();
        emit(
          state.copyWith(
            status: FetchPropertyFilterStatus.success,
            filterInput: state.filterInput.copyWith(
              categories: categories,
              facilities: facilities,
            ),
          ),
        );
      } catch (e) {
        emit(state.copyWith(status: FetchPropertyFilterStatus.error));
      }
    });

    on<UpdatePropertyFilter>((event, emit) async {
      emit(state.copyWith(filterInput: event.filterInput));
    });
  }
}
