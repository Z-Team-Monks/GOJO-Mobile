import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo/features/home/presentation/screen/widgets/rating.dart';
import 'package:gojo/features/home/presentation/screen/widgets/rent_per_month.dart';

import '../../../../Gojo-Mobile-Shared/UI/design_tokens/borders.dart';
import '../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../Gojo-Mobile-Shared/UI/input_fields/search_bar.dart';
import '../../../../Gojo-Mobile-Shared/UI/list_items/media_item.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/icon_text.dart';
import '../../../../Gojo-Mobile-Shared/resources/resources.dart';
import '../../../../constants/strings/app_routes.dart';
import '../../data_layer/model/property_item.dart';
import '../../data_layer/repository/home_repository.dart';
import '../bloc/property_filter/model/filter_input.dart';
import '../bloc/property_filter/property_filter_bloc.dart';
import '../bloc/property_items/property_items_bloc.dart';
import 'home_filter_form_view.dart';

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
          label: "Search for your next home",
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
    return const Center(child: Text("Couldn't fetch properties"));
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
            Navigator.pushNamed(context, GojoRoutes.propertyDetail);
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: GojoMediaItem(
              title: propertyItem.title,
              rightTopTrailingWidget: const Rating(rating: "4.97"),
              rightBottomTrailingWidget:
                  RentPerMonth(rentPerMonth: "${propertyItem.rent}"),
              image: Image(
                image: AssetImage(propertyItem.thumbnailUrl),
                fit: BoxFit.fill,
              ),
              iconTexts: const [
                GojoIconText(
                  iconData: Icons.bed,
                  title: "2 bedrooms",
                ),
                GojoIconText(
                  iconData: Icons.aspect_ratio,
                  title: "214 sq.ms",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
