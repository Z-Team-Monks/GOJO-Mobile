import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo/features/detail/data/repository/detail_repository.dart';
import 'package:gojo/features/detail/presentation/bloc/property_detail/property_detail_bloc.dart';
import 'package:gojo/features/detail/presentation/widgets/page_view_tab.dart';
import '../../../Gojo-Mobile-Shared/UI/design_tokens/borders.dart';
import '../../../Gojo-Mobile-Shared/UI/widgets/icon_text.dart';
import '../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'package:gojo/features/detail/presentation/widgets/tab_view/tab_reviews.dart';
import 'package:gojo/features/detail/presentation/widgets/host_avatar.dart';
import 'package:gojo/features/detail/presentation/widgets/rating.dart';
import 'package:gojo/features/detail/presentation/widgets/tab_view/tab_best.dart';

import '../../review/data/models/review.dart';
import '../data/model/property.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PropertyDetailBloc(
        propertyDetailRepository: PropertyDetailRepositoryFake(),
      )..add(
          LoadPropertyDetail(
            propertyId: "propertyId",
          ),
        ),
      child: const PropertyDetailView(),
    );
  }
}

class PropertyDetailView extends StatelessWidget {
  const PropertyDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      child: SingleChildScrollView(
        child: BlocBuilder<PropertyDetailBloc, PropertyDetailState>(
          builder: (context, state) {
            switch (state.status) {
              case FetchPropertyDetailStatus.loading:
                return const LoadingView();
              case FetchPropertyDetailStatus.success:
                return PropertyDetailViewContent(
                  property: state.property!,
                );
              case FetchPropertyDetailStatus.error:
                return const ErrorView();
            }
          },
        ),
      ),
    );
  }
}

// TODO: Use generic ErrorView
class ErrorView extends StatelessWidget {
  const ErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("Couldn't fetch property detail");
  }
}

// TODO: Use generic LoadingView
class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Center(
      child: Container(
        margin: EdgeInsets.only(top: deviceSize.height * 0.3),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}

class PropertyDetailViewContent extends StatelessWidget {
  final Property property;

  const PropertyDetailViewContent({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                          image: AssetImage('assets/images/sofa.jpeg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: GojoBorders.border(
                          GojoBorderRadiusSize.large,
                        ),
                        color: Colors.amber,
                      ),
                    );
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
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
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
              "${property.category}, ${property.title}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      "${property.price} ETB",
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
              ],
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            property.address,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.grey[500],
                ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            // TODO: use the state values for Gojo Icon text
            GojoIconText(iconData: Icons.bed_rounded, title: "5 bedrooms"),
            GojoIconText(iconData: Icons.aspect_ratio, title: "214 sq.ms"),
            GojoIconText(iconData: Icons.bathtub, title: "2 baths"),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          property.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: HostAvatar(owner: property.owner),
        ),
        TabView(reviews: property.reviews),
      ],
    );
  }
}

class TabView extends StatefulWidget {
  final List<Review> reviews;
  const TabView({super.key, required this.reviews});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  int currentPage = 0;
  final PageController _pageController = PageController();

  scrollTo(int page) {
    setState(
      () {
        currentPage = page;

        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            PageViewTab(
              label: "Best",
              isSelected: currentPage == 0,
              onSelected: (val) => scrollTo(0),
            ),
            const SizedBox(
              width: 20,
            ),
            PageViewTab(
              label: "Reviews",
              isSelected: currentPage == 1,
              onSelected: (val) => scrollTo(1),
            )
          ],
        ),
        ExpandablePageView(
          controller: _pageController,
          children: [
            const TabBest(),
            TabReviews(reviews: widget.reviews),
          ],
        ),
      ],
    );
  }
}
