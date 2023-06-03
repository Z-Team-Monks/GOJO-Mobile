import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:gojo/features/home/data_layer/repository/home_repository.dart';
import 'package:gojo/features/home/presentation/bloc/property_filter/model/filter_input.dart';

import '../../../data_layer/model/property_item.dart';

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

    on<CategorySelected>((event, emit) async {
      var selectedCategories = List.of(state.filterInput.selectedCategories);
      final newCategory = state.filterInput.categories.firstWhere(
        (element) => element.name == event.category,
      );

      if (selectedCategories.contains(newCategory)) {
        selectedCategories.remove(newCategory);
      } else {
        selectedCategories.add(newCategory);
      }
      emit(state.copyWith(
        filterInput: state.filterInput.copyWith(
          selectedCategories: selectedCategories,
        ),
      ));
    });

    on<FacilitySelected>((event, emit) async {
      var selectedFacilities = List.of(state.filterInput.selectedFacilities);
      final newFacility = state.filterInput.facilities.firstWhere(
        (element) => element.name == event.facility,
      );
      if (selectedFacilities.contains(newFacility)) {
        selectedFacilities.remove(newFacility);
      } else {
        selectedFacilities.add(newFacility);
      }
      emit(state.copyWith(
        filterInput: state.filterInput.copyWith(
          selectedFacilities: selectedFacilities,
        ),
      ));
    });

    on<RatingChanged>((event, emit) async {
      emit(state.copyWith(
        filterInput: state.filterInput.copyWith(
          selectedRating: event.rating,
        ),
      ));
    });

    on<PriceRangeChanged>((event, emit) async {
      emit(state.copyWith(
        filterInput: state.filterInput.copyWith(
          maximumPriceRange: event.maximumPriceRange,
          minimumPriceRange: event.minimumPriceRange,
        ),
      ));
    });

    on<UpdatePropertyFilter>((event, emit) async {
      emit(state.copyWith(filterInput: event.filterInput));
    });
  }
}
