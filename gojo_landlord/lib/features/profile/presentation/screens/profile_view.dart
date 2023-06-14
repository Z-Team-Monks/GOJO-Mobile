import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'package:gojo_landlord/features/profile/data_layer/repository/profile_repository.dart';
import 'package:gojo_landlord/features/profile/presentation/bloc/profile/profile_bloc.dart';

import '../../../../Gojo-Mobile-Shared/UI/widgets/circle_icon_button.dart';
import '../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../../../Gojo-Mobile-Shared/shared_features/locale/presentation/bloc/app_locale_bloc.dart';
import '../../../../constants/strings/app_routes.dart';
import '../../../route_guard/presentation/bloc/route_guard_bloc.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/change_language_dialogue.dart';

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
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                ChangeLanguageButton(),
                SizedBox(width: 15),
                LogoutButton(),
              ],
            ),
            const SizedBox(height: 4),
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
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          TabBar(
            tabs: [
              Tab(text: "Posted"),
              Tab(text: "Rented"),
              Tab(text: "In Review"),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: TabBarView(
              children: [
                PostedPropertiesTab(),
                RentedPropertiesTab(),
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
          case FetchPropertyMediaItemStatus.loaded:
            if (state.postedMediaItems.isEmpty) {
              return const Center(child: Text("No posted properties"));
            }
            return ListView.builder(
              itemCount: state.postedMediaItems.length,
              itemBuilder: ((context, index) {
                return state.postedMediaItems[index];
              }),
            );
          case FetchPropertyMediaItemStatus.loading:
            return const LoadingView();
          case FetchPropertyMediaItemStatus.error:
            return const ErrorView();
        }
      },
    );
  }
}

class RentedPropertiesTab extends StatelessWidget {
  const RentedPropertiesTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        switch (state.rentedItemsFetchStatus) {
          case FetchPropertyMediaItemStatus.loaded:
            if (state.rentedMediaItems.isEmpty) {
              return const Center(child: Text("No rented properties"));
            }
            return ListView.builder(
              itemCount: state.rentedMediaItems.length,
              itemBuilder: ((context, index) {
                return state.rentedMediaItems[index];
              }),
            );
          case FetchPropertyMediaItemStatus.loading:
            return const LoadingView();
          case FetchPropertyMediaItemStatus.error:
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
          case FetchPropertyMediaItemStatus.loaded:
            if (state.inReviewMediaItems.isEmpty) {
              return const Center(child: Text("No in review properties"));
            }
            return ListView.builder(
                itemCount: state.inReviewMediaItems.length,
                itemBuilder: ((context, index) {
                  return state.inReviewMediaItems[index];
                }));
          case FetchPropertyMediaItemStatus.loading:
            return const LoadingView();
          case FetchPropertyMediaItemStatus.error:
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

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void changeLanugae(String newLanguage) {
      context
          .read<AppLocaleBloc>()
          .add(ChangeAppLocale(locale: Locale(newLanguage)));
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GojoCircleIconButton(
        icon: Icons.language,
        label: "Language",
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext _) {
              final selectedLanguage =
                  context.read<AppLocaleBloc>().state.locale.languageCode;
              return LanguageDialog(
                selectedLanguage: selectedLanguage,
                onLanguageChanged: changeLanugae,
              );
            },
          );
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
