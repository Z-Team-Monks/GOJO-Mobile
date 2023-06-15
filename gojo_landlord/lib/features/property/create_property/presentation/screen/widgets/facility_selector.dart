import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/input_fields/text_radio_button.dart';
import 'package:gojo_landlord/features/property/create_property/presentation/screen/widgets/form_input_label.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data_layer/model/facility.dart';
import '../../bloc/create_property/create_property_bloc.dart';

class FacilitiesSelector extends StatelessWidget {
  const FacilitiesSelector({
    super.key,
    required this.facilities,
  });

  final List<Facility> facilities;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormInputLabel(label: AppLocalizations.of(context)!.facilities),
        SizedBox(
          height: 200,
          child: ListView(children: [
            GojoTextRadioButton(
              items: facilities.map((f) => f.name).toList(),
              isRadio: false,
              onItemSelected: (value, index, isSelected) => {
                context.read<CreatePropertyBloc>().add(FacilitySelected(value)),
              },
            ),
          ]),
        ),
      ],
    );
  }
}
