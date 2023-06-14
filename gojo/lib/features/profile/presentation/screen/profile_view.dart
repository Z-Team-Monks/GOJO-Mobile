import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/change_language_dialogue.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/circle_icon_button.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../../../Gojo-Mobile-Shared/shared_features/locale/presentation/bloc/app_locale_bloc.dart';
import '../../../../constants/strings/app_routes.dart';
import '../../../route_guard/presentation/bloc/route_guard_bloc.dart';
import '../../data_layer/repository/profile_repository.dart';
import '../bloc/profile_bloc.dart';
import 'profile_icon_button.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: AppLocalizations.of(context)!.profile,
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
            return Center(
              child: Text(AppLocalizations.of(context)!.errorLoadingContent),
            );
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
                    state.user!.displayProfilePicture!,
                  ),
                  radius: 60,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: GojoPadding.medium),
              child: Text(
                "${state.user!.firstName}  ${state.user!.lastName}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
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
              label: AppLocalizations.of(context)!.applications,
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
              label: AppLocalizations.of(context)!.appointments,
              onPressed: () {
                Navigator.pushNamed(context, GojoRoutes.myAppointments);
              },
            ),
          ),
          const SizedBox(width: 15),
          const ChangeLanguageButton(),
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
        label: AppLocalizations.of(context)!.logout,
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
        label: AppLocalizations.of(context)!.language,
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
          children: [
            TabBar(
              tabs: [
                Tab(text: AppLocalizations.of(context)!.rented),
                Tab(text: AppLocalizations.of(context)!.favorites),
              ],
            ),
            const SizedBox(height: 8),
            const Expanded(
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
              emptyChildrenText:
                  AppLocalizations.of(context)!.noRentedProperties,
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
              emptyChildrenText:
                  AppLocalizations.of(context)!.noFavoriteProperties,
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
  final List<Widget> children;
  final String emptyChildrenText;
  const ProfileTab({
    super.key,
    required this.children,
    required this.emptyChildrenText,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(emptyChildrenText),
        ),
      );
    }
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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: const Center(
        child: CircularProgressIndicator(),
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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Center(
          child: Text(
        AppLocalizations.of(context)!.errorLoadingContent,
      )),
    );
  }
}
