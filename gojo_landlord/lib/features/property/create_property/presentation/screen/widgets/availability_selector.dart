import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/input_fields/date_field.dart';
import 'package:gojo_landlord/features/property/create_property/presentation/bloc/create_property/create_property_bloc.dart';
import 'package:gojo_landlord/features/property/create_property/presentation/screen/widgets/form_input_label.dart';
import '../../../../../../utils/date_time.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AvailabilitySelector extends StatefulWidget {
  const AvailabilitySelector({super.key});

  @override
  State<AvailabilitySelector> createState() => _AvailabilitySelectorState();
}

class _AvailabilitySelectorState extends State<AvailabilitySelector> {
  DateTime? selectedStartDate;
  final startDateController = TextEditingController();

  DateTime? selectedEndDate;
  final endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePropertyBloc, CreatePropertyState>(
      builder: (context, state) {
        startDateController.text = state.startDate?.mmddyyy() ?? "";
        endDateController.text = state.endDate?.mmddyyy() ?? "";

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormInputLabel(
              label: AppLocalizations.of(context)!.availability,
              isRequired: true,
            ),
            const SizedBox(height: 8),
            GojoDateField(
                labelText: AppLocalizations.of(context)!.startDate,
                controller: startDateController,
                onPressed: () async {
                  await onStartDateSelected(context);
                }),
          ],
        );
      },
    );
  }

  Future<void> onStartDateSelected(BuildContext context) async {
    final selectedStartDate = await _selectDateInput(context);
    if (selectedStartDate != null && context.mounted) {
      context.read<CreatePropertyBloc>().add(
            StartDateSelected(selectedStartDate),
          );
    }
  }

  Future<void> onEndDateSelected(BuildContext context) async {
    final selectedEndDate = await _selectDateInput(context);
    if (selectedEndDate != null && context.mounted) {
      context.read<CreatePropertyBloc>().add(
            EndDateSelected(selectedEndDate),
          );
    }
  }

  Future<DateTime?> _selectDateInput(BuildContext context) async {
    final currentDate = DateTime.now();
    return await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: selectedEndDate ??
          DateTime(currentDate.year + 1, currentDate.month, currentDate.day),
    );
  }
}
