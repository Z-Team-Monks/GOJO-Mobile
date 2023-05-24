import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/borders.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/icon_text.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../../constants/strings/app_routes.dart';
import '../../../apply_for_rent/presentation/application.dart';
import '../../../favorite/bloc/favorite_bloc.dart';
import '../../../favorite/presentation/favorite_button.dart';
import '../../../schedule_appointment/presentation/screen/schedule_appointment.dart';
import '../../data/model/property.dart';
import '../../data/repository/detail_repository.dart';
import '../bloc/property_detail_bloc.dart';
import 'widgets/host_avatar.dart';
import 'widgets/rating.dart';
import 'widgets/reviews.dart';

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
    return BlocBuilder<PropertyDetailBloc, PropertyDetailState>(
      builder: (context, state) {
        return GojoParentView(
          label: state.property?.title ?? "",
          child: SingleChildScrollView(
            child: BlocBuilder<PropertyDetailBloc, PropertyDetailState>(
              builder: (context, state) {
                switch (state.status) {
                  case FetchPropertyDetailStatus.loading:
                    return const LoadingView();
                  case FetchPropertyDetailStatus.success:
                    return PropertyDetailViewContent(property: state.property!);
                  case FetchPropertyDetailStatus.error:
                    return const ErrorView();
                }
              },
            ),
          ),
        );
      },
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
        BlocBuilder<PropertyDetailBloc, PropertyDetailState>(
          builder: (context, state) {
            return Stack(
              children: [
                CarouselSlider(
                  carouselController: CarouselController(),
                  options: CarouselOptions(
                    aspectRatio: 1.5,
                    viewportFraction: 1,
                  ),
                  items: [1, 2, 3, 4, 5].map((i) {
                    // TODO: Replace with fetched data
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
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingIndicator(
                        rating: state.property!.rating,
                      ),
                      BlocProvider(
                        create: (context) => FavoriteBloc(
                          propertyId: state.property!.id,
                          propertyDetailRepository:
                              GetIt.I<PropertyDetailRepositoryFake>(),
                        )..add(
                            LoadFavorite(
                              isFavorite: state.property!.isFavorite,
                            ),
                          ),
                        child: const FavoriteButton(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${property.category}, ${property.title}",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  property.address,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.grey[500],
                      ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      "${property.price} ETB",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: const Color(0xFF4C9FC1),
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
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
        Row(
          children: const [
            // TODO: use the state values for Gojo Icon text
            GojoIconText(iconData: Icons.bed, title: "5 bedrooms"),
            GojoIconText(
              iconData: Icons.aspect_ratio,
              title: "214 m^2",
            ),
            GojoIconText(iconData: Icons.bathtub, title: "2 baths"),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            GojoBarButton(
              title: "Apply",
              customHeight: 30,
              onClick: () {
                showApplyForRentDialogue(context);
              },
            ),
            const SizedBox(width: 12),
            GojoBarButton(
              title: "360",
              customHeight: 30,
              onClick: () {
                Navigator.pushNamed(context, GojoRoutes.virtualTour);
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          property.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            const Divider(
              thickness: 0.6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HostAvatar(owner: property.owner),
                Row(
                  children: [
                    BlocBuilder<PropertyDetailBloc, PropertyDetailState>(
                      builder: (context, state) {
                        return InkWell(
                          child: const Icon(Icons.calendar_month),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return ScheduleAppointmentView(
                                  availablity: state.property!.availability,
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.my_location),
                      onTap: () {},
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.chat_bubble_outline_rounded),
                      onTap: () {
                        Navigator.pushNamed(context, GojoRoutes.chat);
                      },
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.call),
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
            const Divider(
              thickness: 0.6,
            ),
          ],
        ),
        Reviews(reviews: property.reviews),
      ],
    );
  }

  Future<void> showApplyForRentDialogue(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const ApplicationForm();
      },
    );
  }
}
