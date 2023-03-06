import 'package:flutter/material.dart';
import 'package:gojo/UI/widgets/icon_text.dart';
import 'package:gojo/UI/widgets/media_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: MediaCard(
                    title: "Villa, Kemah Tinggi",
                    iconTexts: const [
                      IconText(
                        iconData: Icons.bed,
                        title: "2 bedrooms",
                      ),
                      IconText(
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
