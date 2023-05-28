import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo/features/home/data_layer/repository/home_repository.dart';
import 'package:gojo/features/home/presentation/bloc/property_filter/model/filter_input.dart';
import 'package:gojo/features/home/data_layer/model/property_item.dart';

part 'property_items_event.dart';
part 'property_items_state.dart';

class PropertyItemsBloc extends Bloc<PropertyItemsEvent, PropertyItemsState> {
  final HomeRepositoryAPI homeRepository;

  PropertyItemsBloc(this.homeRepository) : super(PropertyItemsState.initial()) {
    on<LoadPropertyItems>((event, emit) async {
      emit(state.copyWith(
        searchQuery: event.searchQuery,
        filterInput: event.filterInput,
        status: FetchPropertyItemsStatus.loading,
      ));

      try {
        final filterInput = event.filterInput;
        final searchQuery = event.searchQuery;

        final items = await homeRepository.getPropertyItems(
          searchQuery,
          filterInput,
        );
        emit(state.copyWith(
            status: FetchPropertyItemsStatus.success, items: items));
      } catch (e) {
        emit(state.copyWith(status: FetchPropertyItemsStatus.error));
      }
    });

    on<UpdateFilterInputs>(((event, emit) {
      add(LoadPropertyItems(
        searchQuery: state.searchQuery,
        filterInput: event.filterInput,
      ));
    }));
  }
}
