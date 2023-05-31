import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
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
import 'widgets/visiting_hours/visiting_hour_selector.dart';

class CreatePropertyView extends StatelessWidget {
  const CreatePropertyView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: "New Property",
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
        fetchedFacilities: facilities,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: GojoPadding.small),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const FormInputLabel(
                label: "Info",
                isRequired: true,
              ),
              const SizedBox(height: 8),
              TitleInputField(),
              const SizedBox(height: 12),
              DescriptionInputField(),
              const SizedBox(height: 12),
              RentInputField(),
              const SizedBox(height: 12),
              NumberOfBedRoomsInputField(),
              const SizedBox(height: 12),
              NumberofBathRoomsInputField(),
              const SizedBox(height: 12),
              SquareAreaInputField(),
              const SizedBox(height: 20),
              const AvailabilitySelector(),
              const SizedBox(height: 20),
              const AddressPicker(),
              const SizedBox(height: 20),
              const VisitingHourSelector(),
              const SizedBox(height: 20),
              CategorySelector(categories: categories),
              const SizedBox(height: 20),
              FacilitiesSelector(
                facilities: CreatePropertyBloc.getSelectableFacilites(
                  facilities,
                ),
              ),
              const SizedBox(height: 20),
              const SaveButton(),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleInputField extends StatelessWidget {
  TitleInputField({super.key});

  final _textInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePropertyBloc, CreatePropertyState>(
      builder: (context, state) {
        if (state.titleInput.value != _textInputController.text) {
          _textInputController.text = state.titleInput.value;
        }
        return GojoTextField(
          labelText: "Title",
          controlller: _textInputController,
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

class RentInputField extends StatelessWidget {
  RentInputField({super.key});

  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePropertyBloc, CreatePropertyState>(
      builder: (context, state) {
        if (state.rentInput.value != _inputController.text) {
          _inputController.text = state.rentInput.value;
        }
        return GojoTextField(
          labelText: "Rent",
          controlller: _inputController,
          onChanged: (value) {
            context.read<CreatePropertyBloc>().add(RentInputChanged(value));
          },
          errorText: !state.rentInput.isPure && state.rentInput.isNotValid
              ? state.rentInput.getErrorMessage()
              : null,
        );
      },
    );
  }
}

class SquareAreaInputField extends StatelessWidget {
  SquareAreaInputField({super.key});

  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePropertyBloc, CreatePropertyState>(
      builder: (context, state) {
        if (state.sqaureAreaInput.value != _inputController.text) {
          _inputController.text = state.sqaureAreaInput.value;
        }
        return GojoTextField(
          labelText: "Square area",
          controlller: _inputController,
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
  NumberofBathRoomsInputField({super.key});

  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePropertyBloc, CreatePropertyState>(
      builder: (context, state) {
        if (state.numberOfBathroomsInput.value != _inputController.text) {
          _inputController.text = state.numberOfBathroomsInput.value;
        }
        return GojoTextField(
          labelText: "Number of bathrooms",
          controlller: _inputController,
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
  NumberOfBedRoomsInputField({super.key});

  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePropertyBloc, CreatePropertyState>(
      builder: (context, state) {
        if (state.numberOfBedRoomsInput.value != _inputController.text) {
          _inputController.text = state.numberOfBedRoomsInput.value;
        }
        return GojoTextField(
          labelText: "Number of bedrooms",
          controlller: _inputController,
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
  DescriptionInputField({super.key});

  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePropertyBloc, CreatePropertyState>(
      builder: (context, state) {
        if (state.descriptionInput.value != _inputController.text) {
          _inputController.text = state.descriptionInput.value;
        }
        return GojoTextField(
          labelText: "Description",
          controlller: _inputController,
          maxLines: 5,
          onChanged: (value) {
            context
                .read<CreatePropertyBloc>()
                .add(DescriptionInputChanged(value));
          },
          errorText: !state.descriptionInput.isPure &&
                  state.descriptionInput.isNotValid
              ? state.descriptionInput.getErrorMessage()
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
    return BlocConsumer<CreatePropertyBloc, CreatePropertyState>(
      listener: (context, state) {
        switch (state.postStatus) {
          case CreatePropertyPostStatus.success:
            GojoSnackBars.showSuccess(context,
                "Property created. It will be posted when approved by admin");
            break;
          case CreatePropertyPostStatus.failure:
            GojoSnackBars.showError(context,
                "Can't do operation right now. Please try again later!");
            break;
          case CreatePropertyPostStatus.initial:
            break;
        }
      },
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
    final allFormzInputsAreValid = Formz.validate([
      state.titleInput,
      state.numberOfBedRoomsInput,
      state.numberOfBathroomsInput,
      state.sqaureAreaInput,
      state.address,
      state.descriptionInput,
    ]);

    return allFormzInputsAreValid &&
        state.selectedCategory != null &&
        state.startDate != null;
  }
}
