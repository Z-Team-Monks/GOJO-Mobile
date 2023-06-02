import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../Gojo-Mobile-Shared/UI/list_items/mini_media_item.dart';
import '../../../../Gojo-Mobile-Shared/UI/list_items/property_media_item.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../../../constants/strings/app_routes.dart';
import '../../../route_guard/presentation/bloc/route_guard_bloc.dart';
import '../../data_layer/repository/profile_repository.dart';
import '../bloc/profile_bloc.dart';
import 'model/profile_media_item.dart';
import 'profile_icon_button.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: "Profile",
      child: BlocProvider(
        create: (context) => ProfileBloc(
          GetIt.I<ProfileRepositoryAPI>(),
          GetIt.I<UserRepositoryAPI>(),
        )..add(LoadProfileData()),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                const [UserInfoSection(), ProfileButtons()],
              ),
            ),
            const SliverFillRemaining(
              hasScrollBody: true,
              child: UserPropertiesSection(),
            )
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
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        switch (state.userLoadStatus) {
          case FetchPropertyMediaItemStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case FetchPropertyMediaItemStatus.error:
            return const Center(child: Text("Error loading user data"));
          case FetchPropertyMediaItemStatus.loaded:
            break;
        }
        return Column(
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    state.user!.profilePicture,
                  ),
                  radius: 60,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: GojoPadding.large),
              child: Text(
                "${state.user!.firstName}  ${state.user!.lastName}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: GojoPadding.small),
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
          const SizedBox(width: 15),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ProfileIconButton(
              icon: Icons.calendar_month,
              label: "Appointments",
              onPressed: () {
                Navigator.pushNamed(context, GojoRoutes.myAppointments);
              },
            ),
          ),
          const SizedBox(width: 15),
          const LogoutButton(),
        ],
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ProfileIconButton(
        icon: Icons.logout,
        label: "Logout",
        onPressed: () {
          context.read<RouteGuardBloc>().add(Logout());
          Navigator.pushNamedAndRemoveUntil(
              context, GojoRoutes.app, (route) => false);
        },
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
          case FetchPropertyMediaItemStatus.loaded:
            return ProfileTab(
              children: state.rentedMediaItems,
            );
          case FetchPropertyMediaItemStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case FetchPropertyMediaItemStatus.error:
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
          case FetchPropertyMediaItemStatus.loaded:
            return ProfileTab(
              children: state.favoriteMediaItems,
            );
          case FetchPropertyMediaItemStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case FetchPropertyMediaItemStatus.error:
            return const ErrorView();
        }
      }),
    );
  }
}

class ProfileTab extends StatelessWidget {
  final List<PropertyMediaItem> children;
  const ProfileTab({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: children.length,
      itemBuilder: (context, index) {
        return children[index];
      },
    );
  }
}

/// A widget that displays an image and title of a property.

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
