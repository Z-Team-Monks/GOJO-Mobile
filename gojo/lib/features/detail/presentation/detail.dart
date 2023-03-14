import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gojo/UI/design_tokens/borders.dart';
import 'package:gojo/features/detail/presentation/widgets/host_avatar.dart';
import 'package:gojo/features/detail/presentation/widgets/property_description.dart';
import 'package:gojo/features/detail/presentation/widgets/rating.dart';
import 'package:gojo/features/detail/presentation/widgets/tab_view/tab_best.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  scrollTo(int page) {
    setState(() {
      currentPage = page;

      _pageController.animateToPage(currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate);
    });
  }

  Widget buildPageViewTab(
      {required label,
      required Function(String?) onSelected,
      isSelected = false}) {
    return GestureDetector(
      onTap: () => onSelected(label),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: isSelected
            ? const BoxDecoration(border: Border(bottom: BorderSide(width: 2)))
            : null,
        child: Text(
          label,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 1.5,
                      viewportFraction: 1,
                    ),
                    items: [1, 2, 3, 4, 5].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image:
                                          AssetImage('assets/images/sofa.jpeg'),
                                      fit: BoxFit.cover),
                                  borderRadius: GojoBorders.border(
                                      GojoBorderRadiusSize.large),
                                  color: Colors.amber));
                        },
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        RatingIndicator(
                          rating: 4.97,
                        ),
                        Icon(Icons.heart_broken)
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Villa, The Arsana Estate",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            "1420 ETB",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text(
                            "per month",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 10),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Icon(Icons.heart_broken_rounded)
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text("Jl, Kartika Plaza, 38/1",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: Colors.grey[500])),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  PropertyDescription(
                    itemCount: 5,
                    label: "bedrooms",
                    iconData: Icons.bed_rounded,
                  ),
                  PropertyDescription(
                    itemCount: 214,
                    label: "m2",
                    iconData: Icons.aspect_ratio,
                  ),
                  PropertyDescription(
                    itemCount: 5,
                    label: "baths",
                    iconData: Icons.bathtub,
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Excellent two-storey villa terrace, private pool and parking spaces is located only 5 minutes from the Ashawa Meda",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: HostAvatar(),
              ),
              Row(
                children: [
                  buildPageViewTab(
                      label: "Best",
                      isSelected: currentPage == 0,
                      onSelected: (val) => scrollTo(0)),
                  const SizedBox(
                    width: 20,
                  ),
                  buildPageViewTab(
                      label: "Reviews",
                      isSelected: currentPage == 1,
                      onSelected: (val) => scrollTo(1))
                ],
              ),
              SizedBox(
                height: 200,
                child: PageView(
                  controller: _pageController,
                  children: const [
                    TabBest(),
                    Center(child: Text("Reviews")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
