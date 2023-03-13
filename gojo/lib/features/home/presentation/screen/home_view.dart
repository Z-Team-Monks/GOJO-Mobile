import 'package:flutter/material.dart';
import 'package:gojo/UI/design_tokens/borders.dart';
import 'package:gojo/UI/input_fields/search_bar.dart';
import 'package:gojo/UI/widgets/icon_text.dart';
import 'package:gojo/UI/list_items/media_item.dart';
import 'package:gojo/UI/widgets/parent_view.dart';
import 'package:gojo/features/home/presentation/screen/home_model_sheet.dart';
import 'package:gojo/resources/resources.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      child: SingleChildScrollView(
        child: Column(
          children: [
            GojoSearchBar(
              label: "Search for your next home",
              suffixIcon: InkWell(
                onTap: (() {
                  showModalBottomSheet(
                    shape: GojoBorders.rounded(GojoBorderRadiusSize.large),
                    context: context,
                    builder: (context) {
                      return GojoHomeModalSheet();
                    },
                  );
                }),
                child: Icon(
                  Icons.tune,
                  color: Resources.gojoColors.black,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: GojoMediaItem(
                    title: "Villa, Kemah Tinggi",
                    leftTrailingTitle: "14,000 Birr",
                    image: Image(
                      image: AssetImage(Resources.gojoImages.sofa),
                      fit: BoxFit.fill,
                    ),
                    iconTexts: const [
                      GojoIconText(
                        iconData: Icons.bed,
                        title: "2 bedrooms",
                      ),
                      GojoIconText(
                        iconData: Icons.crop_square,
                        title: "214 sq.ms",
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
