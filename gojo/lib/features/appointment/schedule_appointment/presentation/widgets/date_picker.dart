import 'package:flutter/material.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final String label;
  const DatePicker({super.key, required this.label});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate = DateTime.now();
  final dateFieldController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year, 12, 31),
    );
    if (picked != null && picked != selectedDate) {
      final formattedPickedDate = DateFormat("MM/d/yyyy").format(picked);
      dateFieldController.text = formattedPickedDate.toString();
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GojoTextField(
          labelText: widget.label,
          controlller: dateFieldController,
          suffixIcon: InkWell(
            onTap: () {
              _selectDate(context);
            },
            child: const Icon(
              Icons.today,
              size: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 8.0),
          child: Text(
            "MM/DD/YYYY",
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Colors.black.withOpacity(0.7), fontSize: 11),
          ),
        ),
      ],
    );
  }
}
