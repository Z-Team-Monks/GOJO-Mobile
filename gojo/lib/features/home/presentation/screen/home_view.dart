import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo/constants/strings/app_routes.dart';
import 'package:gojo/features/home/data_layer/model/property_item.dart';
import 'package:gojo/features/home/data_layer/repository/home_repository.dart';
import 'package:gojo/features/home/presentation/bloc/property_filter/property_filter_bloc.dart';
import 'package:gojo/features/home/presentation/bloc/property_filter/model/filter_input.dart';
import 'package:gojo/features/home/presentation/bloc/property_items/property_items_bloc.dart';
import 'package:gojo/features/home/presentation/screen/home_filter_form_view.dart';
import '../../../../Gojo-Mobile-Shared/UI/design_tokens/borders.dart';
import '../../../../Gojo-Mobile-Shared/UI/input_fields/search_bar.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/icon_text.dart';
import '../../../../Gojo-Mobile-Shared/UI/list_items/media_item.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../Gojo-Mobile-Shared/resources/resources.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PropertyItemsBloc(GetIt.I<HomeRepositoryAPI>())
              ..add(
                LoadPropertyItems(
                    searchQuery: "", filterInput: FilterInput.initialState()),
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
        child: SingleChildScrollView(
          child: Column(
            children: const [
              HomeSearchBar(),
              HomeViewContent(),
            ],
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
            child: Icon(
              Icons.tune,
              color: Resources.gojoColors.black,
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
    return const Text("Couldn't fetch properties");
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

    return Container(
      margin: EdgeInsets.only(top: deviceSize.height * 0.3),
      child: const CircularProgressIndicator(),
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
              leftTrailingTitle: propertyItem.rent.toString(),
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
