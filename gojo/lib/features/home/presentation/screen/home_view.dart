import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../Gojo-Mobile-Shared/UI/design_tokens/borders.dart';
import '../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../Gojo-Mobile-Shared/UI/input_fields/search_bar.dart';
import '../../../../Gojo-Mobile-Shared/UI/list_items/media_item.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/icon_text.dart';
import '../../../../Gojo-Mobile-Shared/constants/facilities.dart';
import '../../../../Gojo-Mobile-Shared/resources/resources.dart';
import '../../../../constants/strings/app_routes.dart';
import '../../../../navigation/args/property_detail_args.dart';
import '../../data_layer/model/property_item.dart';
import '../../data_layer/repository/home_repository.dart';
import '../bloc/property_filter/model/filter_input.dart';
import '../bloc/property_filter/property_filter_bloc.dart';
import '../bloc/property_items/property_items_bloc.dart';
import 'home_filter_form_view.dart';
import 'widgets/rating.dart';
import 'widgets/rent_per_month.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Resources.gojoColors.primaryColor,
        elevation: 3,
        onPressed: () {
          Navigator.pushNamed(context, GojoRoutes.map);
        },
        child: const Icon(
          Icons.explore,
          color: Colors.white,
          size: 25,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  PropertyItemsBloc(GetIt.I<HomeRepositoryAPI>())
                    ..add(
                      LoadPropertyItems(
                        searchQuery: "",
                        filterInput: FilterInput.initialState(),
                      ),
                    ),
            ),
            BlocProvider(
              create: (context) =>
                  PropertyFilterBloc(GetIt.I<HomeRepositoryAPI>())
                    ..add(
                      LoadPropertyFilter(),
                    ),
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.all(GojoPadding.medium),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    const [HomeSearchBar()],
                  ),
                ),
                const SliverFillRemaining(
                  hasScrollBody: true,
                  child: HomeViewContent(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final propertyItemsBloc = context.watch<PropertyItemsBloc>();
    final propertyFilterBloc = context.watch<PropertyFilterBloc>();

    return BlocBuilder<PropertyItemsBloc, PropertyItemsState>(
      builder: (context, state) {
        return GojoSearchBar(
          label: AppLocalizations.of(context)!.searchForYourNextHome,
          onChanged: (newValue) {
            propertyItemsBloc.add(
              LoadPropertyItems(
                searchQuery: newValue,
                filterInput: state.filterInput ?? FilterInput.initialState(),
              ),
            );
          },
          suffixIcon: InkWell(
            onTap: (() {
              showModalBottomSheet(
                shape: GojoBorders.rounded(GojoBorderRadiusSize.large),
                context: context,
                builder: (context) {
                  return MultiBlocProvider(providers: [
                    BlocProvider.value(value: propertyItemsBloc),
                    BlocProvider.value(value: propertyFilterBloc),
                  ], child: const GojoHomeFilterFormView());
                },
              );
            }),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Resources.gojoColors.primaryColor,
                ),
                child: const Icon(
                  Icons.tune,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class HomeViewContent extends StatelessWidget {
  const HomeViewContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyItemsBloc, PropertyItemsState>(
        builder: (context, state) {
      switch (state.status) {
        case FetchPropertyItemsStatus.success:
          if (state.items.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context)!.noAvailableProperties),
            );
          }
          return FeedListView(feeditems: state.items);
        case FetchPropertyItemsStatus.error:
          return const ErrorView();
        case FetchPropertyItemsStatus.loading:
          return const LoadingView();
      }
    });
  }
}

// TODO: Use generic ErrorView
class ErrorView extends StatelessWidget {
  const ErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppLocalizations.of(context)!.errorLoadingContent),
    );
  }
}

// TODO: Use generic LoadingView
class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class FeedListView extends StatelessWidget {
  final List<PropertyItem> feeditems;

  const FeedListView({
    Key? key,
    required this.feeditems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: feeditems.length,
      itemBuilder: (context, index) {
        final propertyItem = feeditems[index];

        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              GojoRoutes.propertyDetail,
              arguments: PropertyDetailArgs(id: propertyItem.id),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: GojoMediaItem(
              title: "${propertyItem.category}, ${propertyItem.title}",
              rightTopTrailingWidget: Rating(
                rating: propertyItem.rating.toString(),
              ),
              rightBottomTrailingWidget:
                  RentPerMonth(rentPerMonth: propertyItem.rent),
              image: Image(
                image: CachedNetworkImageProvider(propertyItem.thumbnailUrl),
                fit: BoxFit.cover,
              ),
              iconTexts: [
                getGojoIconText(
                  GojoFacilities.numberOfBedRooms,
                  propertyItem.facilities,
                ),
                getGojoIconText(
                  GojoFacilities.numberOfBathRooms,
                  propertyItem.facilities,
                ),
                getGojoIconText(
                  GojoFacilities.squareArea,
                  propertyItem.facilities,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Facility getFacility(String facilityName, List<Facility> facilities) {
    try {
      return facilities.firstWhere(
        (element) => element.name == facilityName,
      );
    } catch (e) {
      return Facility(name: facilityName, amount: 0, id: -1);
    }
  }

  GojoIconText getGojoIconText(String facilityName, List<Facility> facilities) {
    final facility = getFacility(facilityName, facilities);

    final facilityIconMap = {
      GojoFacilities.numberOfBedRooms: Icons.bed,
      GojoFacilities.numberOfBathRooms: Icons.bathtub,
      GojoFacilities.squareArea: Icons.aspect_ratio,
    };

    return GojoIconText(
      iconData: facilityIconMap[facility.name] ?? Icons.featured_video,
      title: "${facility.amount ?? ''}",
    );
  }
}
