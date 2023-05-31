import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../Gojo-Mobile-Shared/UI/input_fields/date_field.dart';
import '../../../../Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import '../../../../Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import '../../detail/data/repository/detail_repository.dart';
import '../bloc/apply_for_rent_bloc.dart';

class ApplicationForm extends StatelessWidget {
  const ApplicationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApplyForRentBloc(
        propertyDetailRepository: GetIt.I<PropertyDetailRepository>(),
        propertyId: "",
      ),
      child: const _ApplicationForm(),
    );
  }
}

class _ApplicationForm extends StatelessWidget {
  const _ApplicationForm();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ApplyForRentBloc, ApplyForRentState>(
      listener: (context, state) {
        switch (state.status) {
          case ApplicationStatus.success:
            GojoSnackBars.showSuccess(
                context, "Successfully Applied for Rent!");
            break;
          case ApplicationStatus.error:
            GojoSnackBars.showError(context, "Couldn't apply for Rent!");
            break;
          case ApplicationStatus.done:
            Navigator.pop(context);
            break;
          default:
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: BlocBuilder<ApplyForRentBloc, ApplyForRentState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: GojoPadding.extraSmall),
                    child: Text(
                      "Apply",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const _DatePicker(label: "From"),
                  const SizedBox(height: 12),
                  GojoTextField(
                    labelText: "Months",
                    textInputType: TextInputType.number,
                    onChanged: (value) {
                      BlocProvider.of<ApplyForRentBloc>(context).add(
                        MonthsChanged(months: int.parse(value)),
                      );
                    },
                    hintText: "Stay Months",
                  ),
                  const SizedBox(height: 12),
                  GojoTextField(
                    labelText: "Message",
                    hintText: "Message for the Landlord",
                    maxLines: 6,
                    textInputType: TextInputType.multiline,
                    onChanged: (value) {
                      BlocProvider.of<ApplyForRentBloc>(context).add(
                        MessageChanged(message: value),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<ApplyForRentBloc, ApplyForRentState>(
                    builder: (context, state) {
                      return GojoBarButton(
                        title: "Apply",
                        loadingState:
                            state.status == ApplicationStatus.inprogress,
                        isActive: state.isFormValid,
                        onClick: () {
                          BlocProvider.of<ApplyForRentBloc>(context).add(
                            ApplicationSubmitted(),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DatePicker extends StatefulWidget {
  final String label;

  const _DatePicker({
    required this.label,
  });

  @override
  State<_DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<_DatePicker> {
  DateTime? selectedDate = DateTime.now();
  final dateFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GojoDateField(
      labelText: widget.label,
      controller: dateFieldController,
      onPressed: () {
        _selectDate(context);
        BlocProvider.of<ApplyForRentBloc>(context).add(
          StartDateChanged(startDate: selectedDate!),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: _getLastAvailableDate(context),
    );
    if (picked != null && picked != selectedDate) {
      final formattedPickedDate = DateFormat("MM/d/yyyy").format(picked);
      dateFieldController.text = formattedPickedDate.toString();
      setState(() {
        selectedDate = picked;
      });
    }
  }

  DateTime _getLastAvailableDate(BuildContext context) {
    final DateTime now = DateTime.now();
    return DateTime(
      now.year,
      now.month + 1,
      32,
    );
  }
}
