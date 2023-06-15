import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/design_tokens/borders.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import 'package:gojo_landlord/features/property/create_property/presentation/screen/widgets/form_input_label.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data_layer/model/address.dart';
import '../../bloc/create_property/create_property_bloc.dart';

class AddressPicker extends StatelessWidget {
  const AddressPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePropertyBloc, CreatePropertyState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormInputLabel(
              label: AppLocalizations.of(context)!.address,
              isRequired: true,
            ),
            const StreetAddressTitle(),
            GojoBarButton(
              onClick: () {
                _showAddressPickerDialogue(context);
              },
              title: state.address.value != null
                  ? AppLocalizations.of(context)!.changeAddress
                  : AppLocalizations.of(context)!.pickAddress,
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> _showAddressPickerDialogue(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<CreatePropertyBloc>(),
        child: AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                GojoBorderRadius.radius(GojoBorderRadiusSize.medium)),
          ),
          content: Builder(
            builder: (context) {
              var addressPickerDialogueHeight =
                  MediaQuery.of(context).size.height * 0.5;
              var addressPickerDialogueWidth =
                  MediaQuery.of(context).size.width * 0.9;

              return SizedBox(
                width: addressPickerDialogueWidth,
                height: addressPickerDialogueHeight,
                child: const AddressPickerMap(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class StreetAddressTitle extends StatelessWidget {
  const StreetAddressTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePropertyBloc, CreatePropertyState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: state.address.value != null
              ? Text(
                  "📍 ${state.address.value?.street}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.selectedAddressWillShowHere,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class AddressPickerMap extends StatelessWidget {
  const AddressPickerMap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: OpenStreetMapSearchAndPick(
          center: LatLong(9.0385658, 38.7624277),
          buttonColor: Theme.of(context).primaryColor,
          buttonText: AppLocalizations.of(context)!.setCurrentLocation,
          onPicked: (pickedData) {
            debugPrint(pickedData.latLong.latitude.toString());
            debugPrint(pickedData.latLong.longitude.toString());
            debugPrint(pickedData.address);
            context.read<CreatePropertyBloc>().add(
                  AddressSelected(Address(
                    street: pickedData.address,
                    latitude: pickedData.latLong.latitude,
                    longitude: pickedData.latLong.longitude,
                  )),
                );
            Navigator.pop(context);
          }),
    );
  }
}
