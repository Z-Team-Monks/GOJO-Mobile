import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'package:gojo_landlord/features/profile/data_layer/repository/profile_repository.dart';
import 'package:gojo_landlord/features/profile/presentation/bloc/profile_bloc.dart';

import '../../../../Gojo-Mobile-Shared/UI/widgets/circle_icon_button.dart';
import '../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../../../constants/strings/app_routes.dart';
import '../../../route_guard/presentation/bloc/route_guard_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      child: BlocProvider(
        create: (context) => ProfileBloc(
          GetIt.I<ProfileRepositoryAPI>(),
          GetIt.I<UserRepositoryAPI>(),
        )..add(
            LoadProfileData(),
          ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                const [UserInfoSection()],
              ),
            ),
            const SliverFillRemaining(
              child: UserPropertiesSection(),
            )
          ],
        ),
      ),
    );
  }
}

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        switch (state.userLoadStatus) {
          case FetchProfileMediaItemStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case FetchProfileMediaItemStatus.error:
            return const Center(child: Text("Error loading user data"));
          case FetchProfileMediaItemStatus.loaded:
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

class UserPropertiesSection extends StatelessWidget {
  const UserPropertiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          TabBar(
            tabs: [
              Tab(text: "Posted"),
              Tab(text: "In Review"),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: TabBarView(
              children: [
                PostedPropertiesTab(),
                InReviewPropertiesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PostedPropertiesTab extends StatelessWidget {
  const PostedPropertiesTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        switch (state.postedMediaItemsFetchStatus) {
          case FetchProfileMediaItemStatus.loaded:
            return ListView.builder(
              itemCount: state.postedMediaItems.length,
              itemBuilder: ((context, index) {
                return state.postedMediaItems[index];
              }),
            );
          case FetchProfileMediaItemStatus.loading:
            return const LoadingView();
          case FetchProfileMediaItemStatus.error:
            return const ErrorView();
        }
      },
    );
  }
}

class InReviewPropertiesTab extends StatelessWidget {
  const InReviewPropertiesTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        switch (state.inReviewMediaItemsFetchStatus) {
          case FetchProfileMediaItemStatus.loaded:
            return ListView.builder(
                itemCount: state.inReviewMediaItems.length,
                itemBuilder: ((context, index) {
                  return state.inReviewMediaItems[index];
                }));
          case FetchProfileMediaItemStatus.loading:
            return const LoadingView();
          case FetchProfileMediaItemStatus.error:
            return const ErrorView();
        }
      },
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
      child: GojoCircleIconButton(
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
