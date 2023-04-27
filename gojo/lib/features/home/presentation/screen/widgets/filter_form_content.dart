import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/input_fields/text_radio_button.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import 'package:gojo/features/home/presentation/bloc/property_filter/property_filter_bloc.dart';
import 'package:gojo/features/home/presentation/bloc/property_filter/model/filter_input.dart';
import 'package:gojo/features/home/presentation/bloc/property_items/property_items_bloc.dart';
import 'package:gojo/utils/list_extensions.dart';
import 'package:group_button/group_button.dart';

class FilterFormContent extends StatelessWidget {
  RangeValues _sliderRangeValues = const RangeValues(
    minRangeValue,
    maxRangeValue,
  );

  final _ratingValues = const ["1", "2", "3", "4", "5"];

  final _categoryController = GroupButtonController();
  final _facilitiesController = GroupButtonController();
  final _ratingController = GroupButtonController();

  FilterFormContent({super.key});

  @override
  Widget build(BuildContext context) {
    final propertyItemsBloc = BlocProvider.of<PropertyItemsBloc>(context);
    final propertyFilterBloc = BlocProvider.of<PropertyFilterBloc>(context);
    final state = propertyFilterBloc.state;
    _updateControllers(state);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: GojoPadding.large),
      children: [
        const SizedBox(height: 20),
        GojoTextRadioButton(
          label: "Category",
          isRadio: false,
          controller: _categoryController,
          items: state.filterInput.categories,
        ),
        const Padding(
          padding: EdgeInsets.all(GojoPadding.medium),
          child: Text(
            "Price range",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return RangeSlider(
              values: _sliderRangeValues,
              max: maxRangeValue,
              divisions: 10,
              labels: RangeLabels(
                _sliderRangeValues.start.round().toString(),
                _sliderRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _sliderRangeValues = values;
                });
              },
            );
          },
        ),
        GojoTextRadioButton(
          label: "Facilities",
          isRadio: false,
          controller: _facilitiesController,
          items: state.filterInput.facilities,
        ),
        const Padding(
          padding: EdgeInsets.all(GojoPadding.medium),
          child: Text(
            "Location",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const GojoTextField(labelText: ""),
        const SizedBox(height: 10),
        GojoTextRadioButton(
          label: "Rating",
          isRadio: false,
          controller: _ratingController,
          items: _ratingValues,
        ),
        const SizedBox(height: 12),
        GojoBarButton(
          title: "Apply",
          onClick: () {
            _applyNewFilterInputChanges(
              propertyFilterBloc: propertyFilterBloc,
              propertyItemsBloc: propertyItemsBloc,
            );
            Navigator.pop(context);
          },
        ),
        const SizedBox(height: 12),
        GojoBarButton(
          title: "Reset",
          onClick: () {
            final emptyFilterInput = FilterInput.initialState();
            _updateFilterInputs(
              propertyFilterBloc: propertyFilterBloc,
              propertyItemsBloc: propertyItemsBloc,
              filterInput: emptyFilterInput.copyWith(
                categories: state.filterInput.categories,
                facilities: state.filterInput.facilities,
              ),
            );
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  _updateControllers(PropertyFilterState state) {
    _sliderRangeValues = RangeValues(
      state.filterInput.minimumPriceRange,
      state.filterInput.maximumPriceRange,
    );

    _updateController(
      groupButtonController: _categoryController,
      items: state.filterInput.categories,
      selectedItems: state.filterInput.selectedCategories,
    );

    _updateController(
      groupButtonController: _facilitiesController,
      items: state.filterInput.facilities,
      selectedItems: state.filterInput.selectedFacilities,
    );

    _updateController(
      groupButtonController: _ratingController,
      items: _ratingValues,
      selectedItems: state.filterInput.selectedRating,
    );
  }

  _updateController({
    required GroupButtonController groupButtonController,
    required List<String> items,
    required List<String> selectedItems,
  }) {
    groupButtonController.selectIndexes(
      items.getSelectedIndices(selectedItems),
    );

    groupButtonController.unselectIndexes(
      items.getNotSelectedIndices(selectedItems),
    );
  }

  _applyNewFilterInputChanges({
    required PropertyFilterBloc propertyFilterBloc,
    required PropertyItemsBloc propertyItemsBloc,
  }) {
    final state = propertyFilterBloc.state;
    final newFilterInput = state.filterInput.copyWith(
      selectedCategories: state.filterInput.categories.getItemsAtIndices(
        _categoryController.selectedIndexes.toList(),
      ),
      selectedFacilities: state.filterInput.facilities.getItemsAtIndices(
        _facilitiesController.selectedIndexes.toList(),
      ),
      selectedRating: _ratingValues.getItemsAtIndices(
        _ratingController.selectedIndexes.toList(),
      ),
      minimumPriceRange: _sliderRangeValues.start,
      maximumPriceRange: _sliderRangeValues.end,
    );

    _updateFilterInputs(
      propertyFilterBloc: propertyFilterBloc,
      propertyItemsBloc: propertyItemsBloc,
      filterInput: newFilterInput,
    );
  }

  _updateFilterInputs({
    required PropertyFilterBloc propertyFilterBloc,
    required PropertyItemsBloc propertyItemsBloc,
    required FilterInput filterInput,
  }) {
    propertyFilterBloc.add(
      UpdatePropertyFilter(filterInput),
    );
    propertyItemsBloc.add(UpdateFilterInputs(filterInput));
  }

  static const double minRangeValue = 0;
  static const double maxRangeValue = 1000;
}
