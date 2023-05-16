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
import 'package:gojo/features/profile/presentation/screen/model/profile_media_item.dart';
import 'package:gojo/features/profile/presentation/screen/profile_icon_button.dart';

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
          children: const [
            UserInfoSection(),
            ProfileButtons(),
            UserPropertiesSection(),
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

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ProfileIconButton(
              icon: Icons.description,
              label: "Applications",
              onPressed: () {
                Navigator.pushNamed(context, GojoRoutes.applications);
              },
            ),
          ),
          const SizedBox(width: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ProfileIconButton(
              icon: Icons.settings,
              label: "Settings",
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class UserPropertiesSection extends StatelessWidget {
  const UserPropertiesSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            TabBar(
              tabs: [
                Tab(text: "Rented"),
                Tab(text: "Favorites"),
              ],
            ),
            SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                children: [
                  RentedPropertiesTab(),
                  FavoritePropertiesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
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

class FavoritePropertiesTab extends StatelessWidget {
  const FavoritePropertiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: ((context, state) {
        switch (state.favoriteMediaItemsFetchStatus) {
          case FetchProfileMediaItemStatus.loaded:
            return ProfileTab(
              children: state.favoriteMediaItems,
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
