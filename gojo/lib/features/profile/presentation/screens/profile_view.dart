import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/list_items/mini_media_item.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'package:gojo/Gojo-Mobile-Shared/resources/resources.dart';
import 'package:gojo/constants/strings/app_routes.dart';
import 'package:gojo/features/profile/data_layer/repository/profile_repository.dart';
import 'package:gojo/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:gojo/features/profile/presentation/screens/model/profile_media_item.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      child: BlocProvider(
        create: (context) => ProfileBloc(GetIt.I<ProfileRepositoryAPI>())
          ..add(
            LoadProfileData(),
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const UserInfoSection(),
            DefaultTabController(
              length: 2,
              child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    TabBar(
                      tabs: [
                        Tab(text: "Rented"),
                        Tab(text: "Applied"),
                      ],
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: TabBarView(
                        children: [
                          RentedPropertiesTab(),
                          AppliedPropertiesTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TODO: Use data from Auth bloc to display name and image of the current user.
class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(Resources.gojoImages.headShot),
              radius: 60,
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: GojoPadding.large),
          child: Text(
            "Natnael Abay",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class RentedPropertiesTab extends StatelessWidget {
  const RentedPropertiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: ((context, state) {
        switch (state.rentedMediaItemsFetchStatus) {
          case FetchProfileMediaItemStatus.loaded:
            return ProfileTab(
              children: state.rentedMediaItems,
            );
          case FetchProfileMediaItemStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case FetchProfileMediaItemStatus.error:
            return const ErrorView();
        }
      }),
    );
  }
}

class AppliedPropertiesTab extends StatelessWidget {
  const AppliedPropertiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: ((context, state) {
        switch (state.appliedMediaItemsFetchStatus) {
          case FetchProfileMediaItemStatus.loaded:
            return ProfileTab(
              children: state.appliedMediaItems,
            );
          case FetchProfileMediaItemStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case FetchProfileMediaItemStatus.error:
            return const ErrorView();
        }
      }),
    );
  }
}

class ProfileTab extends StatelessWidget {
  final List<ProfileMediaItem> children;
  const ProfileTab({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: children
          .map((profileMediaItem) => ProfileMedia(
                title: profileMediaItem.title,
                image: Image.network(
                  profileMediaItem.thumbnailUrl,
                ),
                onTap: () => Navigator.pushNamed(
                  context,
                  GojoRoutes.propertyDetail,
                ),
              ))
          .toList(),
    );
  }
}

/// A widget that displays an image and title of a property.
class ProfileMedia extends StatelessWidget {
  final String title;
  final Image image;
  final void Function() onTap;

  const ProfileMedia({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: GojoMiniMediaItem(
        image: image,
        title: title,
      ),
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
    return const Center(child: CircularProgressIndicator());
  }
}

// TODO: Use generic ErrorView
class ErrorView extends StatelessWidget {
  const ErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Failed to load data"));
  }
}
