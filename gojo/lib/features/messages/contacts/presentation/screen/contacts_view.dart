import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../../Gojo-Mobile-Shared/UI/list_items/content_item.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../../Gojo-Mobile-Shared/resources/resources.dart';
import '../../../../../constants/strings/app_routes.dart';
import '../../../../../navigation/args/chat_args.dart';
import '../../../../profile/presentation/screen/profile_view.dart';
import '../../data/repository/contact_repository.dart';
import '../bloc/bloc/contact_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactBloc(
        GetIt.I<ContactRepository>(),
      )..add(ContactLoad()),
      child: const _ContactsView(),
    );
  }
}

/// Represents a screen with a list view of user's chat history.
class _ContactsView extends StatelessWidget {
  const _ContactsView();

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: AppLocalizations.of(context)!.messages,
      child: Column(
        children: [
          const SizedBox(height: 10),
          BlocBuilder<ContactBloc, ContactState>(
            builder: (context, state) {
              switch (state.fetchStatus) {
                case FetchContactsStatus.loading:
                  return const LoadingView();
                case FetchContactsStatus.error:
                  return const ErrorView();
                default:
                  if (state.contacts.isEmpty) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Center(
                        child: Text(AppLocalizations.of(context)!.noMessages),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.contacts.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (() {
                          Navigator.pushNamed(
                            context,
                            GojoRoutes.chat,
                            arguments: ChatArgs(
                              messages: state.contacts[index].chatMessages,
                              landlord: state.contacts[index].landlord,
                            ),
                          );
                        }),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: GojoPadding.small),
                          child: GojoContentItem(
                            image: NetworkImage(
                              state.contacts[index].landlord
                                  .displayProfilePicture!,
                            ),
                            title:
                                "${state.contacts[index].landlord.firstName} ${state.contacts[index].landlord.lastName}",
                            content:
                                state.contacts[index].chatMessages.last.message,
                            rightAlignedTitle: state
                                .contacts[index].chatMessages.last.timestamp,
                            rightAlignedContent: "",
                          ),
                        ),
                      );
                    },
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
