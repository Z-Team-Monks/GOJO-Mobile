import 'package:flutter/material.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/design_tokens/padding.dart';

import '../../../data_layer/model/transaction.dart';

class TransactionItem extends StatelessWidget {
  final TransactionType type;
  final String title;
  final String date;
  final String time;
  final String amount;

  const TransactionItem({
    super.key,
    required this.type,
    required this.title,
    required this.date,
    required this.time,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: GojoPadding.small),
      child: Row(
        children: [
          _LeadingIcon(type: type),
          const SizedBox(width: 18),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        date,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey.shade600),
                      ),
                      const _Pipe(),
                      Text(
                        time,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey.shade600),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          const Spacer(),
          Text(
            "${_getAmountPrefix(type)} $amount ETB",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          // const Spacer(),
        ],
      ),
    );
  }

  String _getAmountPrefix(type) {
    switch (type) {
      case TransactionType.payed:
        return "+";
      default:
        return "-";
    }
  }
}

class _Pipe extends StatelessWidget {
  const _Pipe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Text(
        "|",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13,
              color: Colors.grey[400],
            ),
      ),
    );
  }
}

class _LeadingIcon extends StatelessWidget {
  final TransactionType type;
  const _LeadingIcon({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(GojoPadding.medium),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: _getIcon(type),
    );
  }

  Icon _getIcon(TransactionType type) {
    switch (type) {
      case TransactionType.payed:
        return const Icon(
          Icons.payments,
          color: Colors.green,
        );
      case TransactionType.approved:
        return const Icon(
          Icons.credit_card,
          color: Colors.red,
        );
      case TransactionType.denied:
        return const Icon(
          Icons.do_not_disturb,
          color: Colors.red,
        );
      case TransactionType.pending:
        return const Icon(
          Icons.pending,
          color: Colors.blue,
        );
      default:
        return const Icon(
          Icons.money,
          color: Colors.blue,
        );
    }
  }
}
