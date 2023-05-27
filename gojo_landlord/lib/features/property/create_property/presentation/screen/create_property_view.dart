import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo_landlord/features/property/create_property/data_layer/property_repository.dart';
import 'package:gojo_landlord/features/property/create_property/data_layer/model/category.dart';
import 'package:gojo_landlord/features/property/create_property/data_layer/model/facility.dart';
import 'package:gojo_landlord/features/property/create_property/presentation/screen/widgets/category_selector.dart';

import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../../Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../bloc/create_property/create_property_bloc.dart';
import '../bloc/property_form_values/property_form_values_bloc.dart';
import 'widgets/availability_selector.dart';
import 'widgets/facility_selector.dart';
import 'widgets/form_input_label.dart';
import 'widgets/adress_picker.dart';
import 'widgets/time_picker.dart';

class CreatePropertyView extends StatelessWidget {
  const CreatePropertyView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: "Add a new property",
      child: BlocProvider(
        create: (context) =>
            PropertyFormValuesBloc(GetIt.I<PropertyRepositoryAPI>())
              ..add(LoadPropertyFormValues()),
        child: BlocBuilder<PropertyFormValuesBloc, PropertyFormValuesState>(
          builder: (context, state) {
            switch (state.fetchState) {
              case PropertyFormValuesFetchState.loading:
                return const Center(child: CircularProgressIndicator());
              case PropertyFormValuesFetchState.failure:
                return const Center(
                  child: Text("Can't load form at the moment"),
                );
              case PropertyFormValuesFetchState.success:
                return CreatePropertyForm(
                  facilities: state.facilities,
                  categories: state.categories,
                );
            }
          },
        ),
      ),
    );
  }
}

class CreatePropertyForm extends StatelessWidget {
  const CreatePropertyForm({
    super.key,
    required this.facilities,
    required this.categories,
  });

  final List<Facility> facilities;
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePropertyBloc(
          propertyRepository: GetIt.I<PropertyRepositoryAPI>(),
          fetchedCategories: categories,
          fetchedFacilities: facilities),
      child: BlocBuilder<CreatePropertyBloc, CreatePropertyState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: GojoPadding.small),
            child: ListView(
              children: [
                const FormInputLabel(
                  label: "Info",
                  isRequired: true,
                ),
                const SizedBox(height: 8),
                const TitleInputField(),
                const SizedBox(height: 12),
                const DescriptionInputField(),
                const SizedBox(height: 12),
                const NumberOfBedRoomsInputField(),
                const SizedBox(height: 12),
                const NumberofBathRoomsInputField(),
                const SizedBox(height: 12),
                const SquareAreaInputField(),
                const SizedBox(height: 20),
                const AvailabilitySelector(),
                const SizedBox(height: 20),
                const AddressPicker(),
                const SizedBox(height: 20),
                const TimePickerRow(),
                const SizedBox(height: 20),
                CategorySelector(categories: categories),
                const SizedBox(height: 20),
                FacilitiesSelector(facilities: facilities),
                const SizedBox(height: 20),
                const SaveButton(),
                const SizedBox(height: 12),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SquareAreaInputField extends StatelessWidget {
  const SquareAreaInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePropertyBloc, CreatePropertyState>(
      builder: (context, state) {
        return GojoTextField(
          labelText: "Square area",
          onChanged: (value) {
            context
                .read<CreatePropertyBloc>()
                .add(SqaureAreaInputChanged(value));
          },
          errorText:
              !state.sqaureAreaInput.isPure && state.sqaureAreaInput.isNotValid
                  ? state.sqaureAreaInput.getErrorMessage()
                  : null,
        );
      },
    );
  }
}

class NumberofBathRoomsInputField extends StatelessWidget {
  const NumberofBathRoomsInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePropertyBloc, CreatePropertyState>(
      builder: (context, state) {
        return GojoTextField(
          labelText: "Number of bathrooms",
          onChanged: (value) {
            context
                .read<CreatePropertyBloc>()
                .add(NumberOfBathRoomsInputChanged(value));
          },
          errorText: !state.numberOfBathroomsInput.isPure &&
                  state.numberOfBathroomsInput.isNotValid
              ? state.numberOfBathroomsInput.getErrorMessage()
              : null,
        );
      },
    );
  }
}

class NumberOfBedRoomsInputField extends StatelessWidget {
  const NumberOfBedRoomsInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePropertyBloc, CreatePropertyState>(
      builder: (context, state) {
        return GojoTextField(
          labelText: "Number of bedrooms",
          onChanged: (value) {
            context
                .read<CreatePropertyBloc>()
                .add(NumberOfBedRoomsInputChanged(value));
          },
          errorText: !state.numberOfBedRoomsInput.isPure &&
                  state.numberOfBedRoomsInput.isNotValid
              ? state.numberOfBedRoomsInput.getErrorMessage()
              : null,
        );
      },
    );
  }
}

class DescriptionInputField extends StatelessWidget {
  const DescriptionInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GojoTextField(
      labelText: "Description",
      maxLines: 5,
      onChanged: (value) {
        context.read<CreatePropertyBloc>().add(DescriptionInputChanged(value));
      },
    );
  }
}

class TitleInputField extends StatelessWidget {
  const TitleInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePropertyBloc, CreatePropertyState>(
      builder: (context, state) {
        return GojoTextField(
          labelText: "Title",
          onChanged: (value) {
            context.read<CreatePropertyBloc>().add(TitleInputChanged(value));
          },
          errorText: !state.titleInput.isPure && state.titleInput.isNotValid
              ? state.titleInput.getErrorMessage()
              : null,
        );
      },
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePropertyBloc, CreatePropertyState>(
      builder: (context, state) {
        final isButtonActive = isFormValid(state);
        return GojoBarButton(
          title: "Save",
          isActive: isButtonActive,
          onClick: (() {
            if (isButtonActive) {
              context.read<CreatePropertyBloc>().add(SaveButtonPressed());
            }
          }),
        );
      },
    );
  }

  bool isFormValid(CreatePropertyState state) {
    final allFormsInputsAreValid = Formz.validate([
      state.titleInput,
      state.numberOfBedRoomsInput,
      state.numberOfBathroomsInput,
      state.sqaureAreaInput,
      state.address,
    ]);

    return allFormsInputsAreValid &&
        state.selectedCategory != null &&
        state.startDate != null &&
        state.endDate != null;
  }
}
