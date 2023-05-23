import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/design_tokens/borders.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import 'package:gojo/Gojo-Mobile-Shared/resources/resources.dart';
import 'package:gojo/features/applications/presentation/model/application_status.dart';

class ApplicationRequestItem extends StatelessWidget {
  final String leadingImageUrl;
  final String title;
  final ApplicationStatusType status;
  final String topRightDate;
  final String startDate;
  final String endDate;
  final String description;
  final Function()? onWithDraw;

  const ApplicationRequestItem({
    super.key,
    required this.leadingImageUrl,
    required this.title,
    required this.status,
    required this.topRightDate,
    required this.startDate,
    required this.endDate,
    required this.description,
    this.onWithDraw,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(GojoPadding.medium),
      margin: const EdgeInsets.symmetric(vertical: GojoPadding.extraSmall),
      decoration: BoxDecoration(
        borderRadius: GojoBorders.border(GojoBorderRadiusSize.small),
        border: Border.all(
          color: Colors.black.withOpacity(0.1),
        ),
      ),
      child: ExpandablePanel(
        header: Row(
          children: [
            Expanded(
              child: ApplicationCollapsed(
                leadingImageUrl: leadingImageUrl,
                title: title,
                status: status,
                topRightDate: topRightDate,
              ),
            ),
          ],
        ),
        collapsed: Container(),
        expanded: Column(
          children: [
            ApplicationExpanded(
              startDate: startDate,
              endDate: endDate,
              description: description,
              status: status,
              onWithDraw: onWithDraw,
            ),
          ],
        ),
      ),
    );
  }
}

class ApplicationCollapsed extends StatelessWidget {
  final String leadingImageUrl;
  final String title;
  final ApplicationStatusType status;
  final String topRightDate;

  const ApplicationCollapsed({
    super.key,
    required this.leadingImageUrl,
    required this.title,
    required this.status,
    required this.topRightDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(leadingImageUrl),
          radius: 30,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Status: ",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 2),
                        ApplicationStatus(
                          type: status,
                        ),
                      ],
                    )
                  ],
                ),
                Text(
                  topRightDate,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.7),
                      ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ApplicationExpanded extends StatelessWidget {
  final String startDate;
  final String endDate;
  final String description;
  final ApplicationStatusType status;
  final Function()? onWithDraw;

  const ApplicationExpanded({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.status,
    this.onWithDraw,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 24),
      margin: const EdgeInsets.only(left: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("Date:"),
              const SizedBox(width: 4),
              Text(
                getFormattedRangeDate(startDate, endDate),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7),
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 12),
          Visibility(
            visible: status == ApplicationStatusType.pending,
            child: GojoBarButton(
              title: "Withdraw",
              onClick: onWithDraw,
              customHeight: 30,
              customWidth: 150,
            ),
          )
        ],
      ),
    );
  }

  String getFormattedRangeDate(String startDate, String endDate) {
    return "$startDate - $endDate";
  }
}
