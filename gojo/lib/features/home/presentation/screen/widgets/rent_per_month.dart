import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RentPerMonth extends StatelessWidget {
  final String rentPerMonth;
  const RentPerMonth({super.key, required this.rentPerMonth});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$rentPerMonth ETB ",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w800,
              ),
        ),
        Text(
          "/ ${AppLocalizations.of(context)!.perMonth}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
