import 'package:flutter/material.dart';

import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../../Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import '../../../../appointment/schedule_appointment/presentation/screen/widgets/date_picker.dart';

class ApplicationForm extends StatelessWidget {
  const ApplicationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: GojoPadding.extraSmall),
              child: Text(
                "Apply",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 14),
            const DatePicker(label: "From"),
            const SizedBox(height: 12),
            const DatePicker(label: "To"),
            const SizedBox(height: 12),
            const GojoTextField(maxLines: 6),
            const SizedBox(height: 12),
            GojoBarButton(title: "Apply", onClick: () {})
          ],
        ),
      ),
    );
  }
}
