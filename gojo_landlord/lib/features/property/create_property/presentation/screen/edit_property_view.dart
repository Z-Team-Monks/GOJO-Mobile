import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import 'package:gojo_landlord/features/property/create_property/data_layer/property_repository.dart';
import 'package:gojo_landlord/features/property/create_property/data_layer/model/category.dart';
import 'package:gojo_landlord/features/property/create_property/data_layer/model/facility.dart';
import 'package:gojo_landlord/features/property/create_property/presentation/model/title_input.dart';
import 'package:gojo_landlord/features/property/create_property/presentation/screen/widgets/category_selector.dart';

import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../../Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../../Gojo-Mobile-Shared/constants/facilities.dart';
import '../../../../profile/data_layer/model/property_item.dart';
import '../../data_layer/model/visiting_hour.dart';
import '../bloc/create_property/create_property_bloc.dart';
import '../bloc/property_form_values/property_form_values_bloc.dart';
import '../model/address_input.dart';
import '../model/description_input.dart';
import '../model/number_of_bathrooms.dart';
import '../model/number_of_bedrooms_input.dart';
import '../model/rent_input.dart';
import '../model/square_area_input.dart';
import 'widgets/facility_selector.dart';
import 'widgets/form_input_label.dart';
import 'widgets/adress_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditPropertyView extends StatelessWidget {
  final PropertyItem propertyItem;
  const EditPropertyView({
    Key? key,
    required this.propertyItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: AppLocalizations.of(context)!.edit_property,
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
                return Center(
                  child: Text(
                    AppLocalizations.of(context)!.errorLoadingContent,
                  ),
                );
              case PropertyFormValuesFetchState.success:
                return EditPropertyForm(
                  facilities: state.facilities,
                  categories: state.categories,
                  propertyItem: propertyItem,
                );
            }
          },
        ),
      ),
    );
  }
}

class EditPropertyForm extends StatelessWidget {
  final PropertyItem propertyItem;

  const EditPropertyForm({
    super.key,
    required this.facilities,
    required this.categories,
    required this.propertyItem,
  });

  final List<Facility> facilities;
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    CreatePropertyState getInitialState() {
      final inputFilters = [
        GojoFacilities.numberOfBedRooms,
        GojoFacilities.numberOfBathRooms,
        GojoFacilities.squareArea,
      ];

      final numberOfBedRooms = propertyItem.facilities
          ?.firstWhere(
              (element) => element.name == GojoFacilities.numberOfBedRooms)
          .amount;

      final numberOfBathRooms = propertyItem.facilities
          ?.firstWhere(
              (element) => element.name == GojoFacilities.numberOfBathRooms)
          .amount;

      final squareArea = propertyItem.facilities
          ?.firstWhere(
            (element) => element.name == GojoFacilities.squareArea,
          )
          .amount;

      var facilitiesWithoutInputFilters = [...propertyItem.facilities ?? []];
      facilitiesWithoutInputFilters.removeWhere(
        (element) => inputFilters.contains(element.name),
      );
      final selectedFacilities =
          facilitiesWithoutInputFilters.map((f) => f.name).toSet();

      return CreatePropertyState(
        titleInput: TitleInput.dirty(value: propertyItem.title),
        descriptionInput: DescriptionInput.dirty(
          value: propertyItem.description,
        ),
        rentInput: RentInput.dirty(value: "${propertyItem.rent}" ?? ""),
        numberOfBedRoomsInput:
            NumberOfBedRoomsInput.dirty(value: numberOfBedRooms.toString()),
        numberOfBathroomsInput:
            NumberOfBathroomsInput.dirty(value: numberOfBathRooms.toString()),
        sqaureAreaInput: SquareAreaInput.dirty(value: squareArea.toString()),
        selectedCategory: propertyItem.category,
        selectedFacilities: {...selectedFacilities},
        startDate: null,
        endDate: null,
        address: AddressInput.dirty(value: propertyItem.address),
        weeklyVisitingHours: WeeklyVisitingHours(),
        postStatus: CreatePropertyPostStatus.initial,
      );
    }

    return BlocProvider(
      create: (context) => CreatePropertyBloc(
        propertyRepository: GetIt.I<PropertyRepositoryAPI>(),
        fetchedCategories: categories,
        fetchedFacilities: facilities,
        initialState: getInitialState(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: GojoPadding.small),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormInputLabel(
                label: AppLocalizations.of(context)!.info,
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
              const AddressPicker(),
              const SizedBox(height: 20),
              CategorySelector(categories: categories),
              const SizedBox(height: 20),
              // FacilitiesSelector(
              //   facilities: CreatePropertyBloc.getSelectableFacilites(
              //     facilities,
              //   ),
              // ),
              const SizedBox(height: 20),
              SaveButton(propertyId: propertyItem.id),
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
          labelText: AppLocalizations.of(context)!.title,
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
          labelText: AppLocalizations.of(context)!.rent,
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
          labelText: AppLocalizations.of(context)!.squareArea,
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
          labelText: AppLocalizations.of(context)!.number_of_bathrooms,
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
          labelText: AppLocalizations.of(context)!.number_of_bedrooms,
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
          labelText: AppLocalizations.of(context)!.description,
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
  final int propertyId;
  const SaveButton({
    super.key,
    required this.propertyId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatePropertyBloc, CreatePropertyState>(
      listener: (context, state) {
        switch (state.postStatus) {
          case CreatePropertyPostStatus.success:
            GojoSnackBars.showSuccess(context, "Property updated successfully");
            Navigator.pop(context);
            break;
          case CreatePropertyPostStatus.failure:
            GojoSnackBars.showError(
                context, AppLocalizations.of(context)!.cantDoOperationRightNow);
            break;
          case CreatePropertyPostStatus.initial:
            break;
        }
      },
      builder: (context, state) {
        return GojoBarButton(
          title: AppLocalizations.of(context)!.save,
          onClick: (() {
            context
                .read<CreatePropertyBloc>()
                .add(EditSaveButtonPressed(propertyId));
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
