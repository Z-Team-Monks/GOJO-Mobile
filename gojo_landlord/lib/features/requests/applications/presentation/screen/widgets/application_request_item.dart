import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../Gojo-Mobile-Shared/resources/resources.dart';
import 'text_button.dart';

class ApplicationRequestItem extends StatelessWidget {
  final String leadingImageUrl;
  final String title;
  final String topRightDate;
  final String startDate;
  final String endDate;
  final String description;
  final void Function() onReject;
  final void Function() onApprove;

  const ApplicationRequestItem({
    super.key,
    required this.leadingImageUrl,
    required this.title,
    required this.topRightDate,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.onReject,
    required this.onApprove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: CachedNetworkImageProvider(
                        leadingImageUrl,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
                Text(topRightDate),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Text("Date:"),
                const SizedBox(width: 4),
                Text(
                  "$startDate - $endDate",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.7),
                      ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.fade,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: GojoTextButton(
                    label: "Reject",
                    onPressed: onReject,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: GojoTextButton(
                    label: "Approve",
                    onPressed: onApprove,
                    color: Resources.gojoColors.primaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
